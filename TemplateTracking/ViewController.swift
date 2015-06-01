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
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var leftImageView: NSImageView!
    @IBOutlet weak var rightImageView: NSImageView!

    // this shouldn't really move
    let movingSearchRectangle = NSView()
    let modelHistogram = ColorHistogram()
    
    var largeImageViewPlaceholder: NSImageView!
    var smallImageViewPlaceholder: NSImageView!
    
    @IBAction func Track(sender: AnyObject) {
        // access and convert images here
        var img = leftImageView.image?.CGImage
        var pixels = getRGBFromImage(img!)

        for i in 0...pixels.count-1 {
            modelHistogram.histoCount(Double(pixels[i].r), g: Double(pixels[i].g), b: Double(pixels[i].b))
        }
        
        // get the background and start projecting
        var targetImg = rightImageView.image?.CGImage
        var bp = backProjectionFind(targetImg!)
        
        var sW = CGImageGetWidth(img)
        var sH = CGImageGetHeight(img)
        var bW = CGImageGetWidth(targetImg)
        var bH = CGImageGetHeight(targetImg)
        
        var compareMatrix = [Double]()
        
        for x in 0...bW-sW-1 {
            for y in 0...bH-sH-1 {
                
            }
        }
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
    func createSearchRectangle(smallImageView: NSImageView, largeImageView: NSImageView) {
        
    }
    
    // reposition the 'search rectangle'
    func repositionRectanglePosition(fullWidth: Float, fullHeight: Float, xPos: Float, yPos: Float) -> (Int, Int, Int, Int) {
        return (0,0,0,0)
    }
    
    // simple resize
    func resize(sourceImage: NSImage, scaleFactor: Float) -> NSImage {
        return NSImage()
    }
    
    // MARK: UI functions
    
    @IBAction func dragAndDrop(sender: AnyObject) {
        
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

