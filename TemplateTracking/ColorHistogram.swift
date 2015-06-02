//
//  ColorHistogram.swift
//  TemplateTracking
//
//  Created by mingkai on 2015-05-31.
//  Copyright (c) 2015 mingkai. All rights reserved.
//

import Foundation

let firstD = Double(10)
let secondD = Double(10)
let thirdD = Double(10)

private func histoMapping(r: Double, g: Double, b: Double) -> Int {
    var x = r-g
    var y = 2*b-r-g
    var z=r+g+b
    
    // assume rgb values are between 0 and 255
    x=(x+255)*firstD/510 // 0 to 15
    y=(y+510)*secondD/1020 // 0 to 15
    z=z*thirdD/765 // 0 to 7
    
    let i = Int(x)+Int(y)*16+Int(z)*8
    
    return i
}

struct ColorHistogram {
    var histo = NSMutableArray(capacity: Int(firstD*secondD*thirdD))
    
    init() {
        for i in 0...Int(firstD*secondD*thirdD) {
            histo.addObject(Int(0))
        }
    }
    
    func histoSet(value: Int, r: Double, g: Double, b: Double) {
        histo[histoMapping(r, g, b)] = value
    }
    
    func histoGet(r: Double, g: Double, b: Double) -> Int {
        return Int(histo[histoMapping(r, g, b)] as! NSNumber)
    }
    
    func histoCount(r: Double, g: Double, b: Double) {
        histo[histoMapping(r, g, b)] = Int(histo[histoMapping(r, g, b)] as! NSNumber)+1
    }
}