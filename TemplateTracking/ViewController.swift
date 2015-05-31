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
        
        var width = CGImageGetWidth(img);
        var height = CGImageGetHeight(img);
    }
    
    // MARK: Main function: Swain and Ballard's Back Projection
    
    // process the entire video for template locations
    func videoTemplateFind() {
        // set the modelHistogram
        
        // back project the first frame, then use convolution with a circular mask to find the initial position of the template
        
        // obtain the back projection, but use mean shift for the rest of the frames
        
    }
    
    // obtain the back projection (comparion matrix) for a single frame
    func backProjectionFind(TargetImage: CIImage) {
        let imageHistogram = ColorHistogram()
        
        // obtain the histogram of the frame
        
        
        // obtain ratio histogram: min(model/image, 1)
        
        // back projection: obtain an matrix of comparison values obtained from mapping pixels to ratio histogram
        
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

