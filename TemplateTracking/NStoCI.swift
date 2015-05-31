//
//  NStoCI.swift
//  TemplateTracking
//
//  Created by mingkai on 2015-05-31.
//  Copyright (c) 2015 mingkai. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

extension NSImage {
    var CGImage: CGImageRef {
        get {
            let imageData = self.TIFFRepresentation
            let source = CGImageSourceCreateWithData(imageData as! CFDataRef, nil)
            let maskRef = CGImageSourceCreateImageAtIndex(source, Int(0), nil)
            return maskRef;
        }
    }
}