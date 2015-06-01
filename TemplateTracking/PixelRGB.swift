//
//  PixelRGB.swift
//  TemplateTracking
//
//  Created by mingkai on 2015-06-01.
//  Copyright (c) 2015 mingkai. All rights reserved.
//

import Foundation

struct PixelRGB {
    var r: CUnsignedChar = 0
    var g: CUnsignedChar = 0
    var b: CUnsignedChar = 0
    
    init(red: CUnsignedChar, green: CUnsignedChar, blue: CUnsignedChar) {
        r = red
        g = green
        b = blue
    }
}