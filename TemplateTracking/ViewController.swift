//
//  ViewController.swift
//  TemplateTracking
//
//  Created by mingkai on 2015-05-31.
//  Copyright (c) 2015 mingkai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var trackBtn: NSButton!
    @IBOutlet weak var leftImageView: NSImageView!
    @IBOutlet weak var rightImageView: NSImageView!

    // this shouldn't really move
    let targetMarker = NSView()
    let modelHistogram = ColorHistogram()
    
    var largeImageViewPlaceholder: NSImageView!
    var smallImageViewPlaceholder: NSImageView!
    
    @IBAction func Track(sender: AnyObject) {
        smallImageViewPlaceholder = leftImageView
        largeImageViewPlaceholder = rightImageView
        
        var backgroundQueue = NSOperationQueue()
        backgroundQueue.addOperationWithBlock({
            
            // access and convert images here
            var img = self.leftImageView.image?.CGImage
            var pixels = self.getRGBFromImage(img!)
            
            for i in 0...pixels.count-1 {
                self.modelHistogram.histoCount(Double(pixels[i].r), g: Double(pixels[i].g), b: Double(pixels[i].b))
            }
            
            // get the background and start projecting
            var targetImg = self.rightImageView.image?.CGImage
            var bp = self.backProjectionFind(targetImg!)
        
            // obtain the convolution to find the template location
            var index = 0
            
            var max = Double(0)
            for x in 0...bp.count-1 {
                if bp[x] > max {
                    max = bp[x]
                    index = x
                }
            }
            
            var sW = CGImageGetWidth(img)
            var sH = CGImageGetHeight(img)
            var bW = CGImageGetWidth(targetImg)
            var bH = CGImageGetHeight(targetImg)
            let maxX = index % bW
            let maxY = index / bW
            
            /*
            var index = 0
            var maxIndex = 0
            var max = Double(0)
            
            for y in 0...bH-sH-1 {
                for x in 0...bW-sW-1 {
                    var compareValue = Double(0)
                    for h in 0...sH-1 {
                        compareValue += bp[x+(y+sH)*bW...x+sW+(y+sH)*bW-1].reduce(0, combine: +)
                    }
                    if (compareValue > max) {
                        maxIndex = index
                    }
                    index++
                }
            }
            
            let maxX = maxIndex % (bW-sW)
            let maxY = maxIndex / (bW-sW)*/
            
            // my PoV --------------------- rectangle's PoV
            // x goes from left to right -- x goes from left to right
            // y goes from up to down ----- y goes from down to up
            let squareSize = (sW > sH ? sH : sW)/10
            self.createTargetMarker(self.largeImageViewPlaceholder, x: maxX, y: bH-sH, width: squareSize, height: squareSize)
            
        })
    }
    
    func getRGBFromImage(imageRef: CGImageRef) -> [PixelRGB] {
        let count = CGImageGetWidth(imageRef)*CGImageGetHeight(imageRef)
        let provider = CGImageGetDataProvider(imageRef)
        let data: NSData = CGDataProviderCopyData(provider)
        
        var rawData: UnsafePointer = UnsafePointer<PixelRGB>(data.bytes)
        var result = [PixelRGB]()
        
        for i in 0...count-1 {
            result.append(rawData.memory)
            rawData = rawData.advancedBy(1)
        }
        
        return result;
    }
    
    // MARK: Main function: Swain and Ballard's Back Projection
    
    // process the entire video for template locations
    func videoTemplateFind() {
        // set the modelHistogram
        
        // back project the first frame, then use convolution with a circular mask to find the initial position of the template
        
        // obtain the back projection, but use mean shift for the rest of the frames
        
    }
    
    // obtain the back projection (comparion matrix) for a single frame
    func backProjectionFind(TargetImage: CGImageRef) -> [Double]{
        let imageHistogram = ColorHistogram()
        
        var result = [Double]()
        
        // obtain the histogram of the frame
        var pixels = getRGBFromImage(TargetImage)
        
        for i in 0...pixels.count-1 {
            imageHistogram.histoCount(Double(pixels[i].r), g: Double(pixels[i].g), b: Double(pixels[i].b))
        }
        
        // obtain ratio histogram: min(model/image, 1) and back project at the same time
        // back projection: obtain an matrix of comparison values obtained from mapping pixels to ratio histogram
        for i in 0...pixels.count-1 {
            let r = Double(pixels[i].r)
            let g = Double(pixels[i].g)
            let b = Double(pixels[i].b)
            let index = modelHistogram.histoGet(r, g: g, b: b)/imageHistogram.histoGet(r, g: g, b: b)
            result.append(Double(index>1 ? 1 : index))
        }
        
        return result
    }
    
    // MARK: Utility functions
    
    // check image sizes - can they even be compared?
    func checkImageComparable() -> Bool {
        
        return true;
    }
    
    // create UI 'search rectangle'
    func createTargetMarker(img:NSImageView, x: Int, y: Int, width: Int, height: Int) {
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.targetMarker.frame = CGRect(x: x, y: y, width: width, height: height)
            
            self.targetMarker.wantsLayer = true
            self.targetMarker.acceptsTouchEvents = false
            self.targetMarker.layer?.borderWidth = 5.0
            self.targetMarker.layer?.borderColor = NSColor.grayColor().CGColor
            
            img.addSubview(self.targetMarker);
        })
    }
    
    // reposition the 'search rectangle'
    func repositionRectanglePosition(fullWidth: Float, fullHeight: Float, xPos: Float, yPos: Float) -> (Int, Int, Int, Int) {
        return (0,0,0,0)
    }
    
    // MARK: UI functions
    
    @IBAction func dragAndDrop(sender: AnyObject) {
        self.targetMarker.layer?.borderColor = NSColor.clearColor().CGColor
        
        if leftImageView.image != nil && rightImageView.image != nil {
            trackBtn.enabled = true
        } else {
            trackBtn.enabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

