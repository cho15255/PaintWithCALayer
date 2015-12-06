//
//  JHUtil.swift
//  PaintWithMetal
//
//  Created by Jae Hee Cho on 2015-11-29.
//  Copyright © 2015 Jae Hee Cho. All rights reserved.
//

import Foundation
import UIKit

func distanceBetween(pointA a:CGPoint, pointB b:CGPoint) -> CGFloat {
    let difference = CGPointMake(b.x - a.x, b.y - a.y)
    return mag(difference)
}

func mag(v:CGPoint) -> CGFloat {
    return sqrt(v.x * v.x + v.y * v.y)
}

func normalize(v:CGPoint) -> CGPoint {
    let l = mag(v)
    return CGPointMake(v.x / l, v.y / l)
}

func getMidpointBetween(pointA:CGPoint, and pointB:CGPoint) -> CGPoint {
    return CGPointMake((pointA.x + pointB.x)/2 , (pointA.y + pointB.y)/2)
}

func getDirectionVectorFrom(a:CGPoint, to b:CGPoint) -> CGPoint {
    let direction = CGPointMake(b.x - a.x, b.y - a.y)
    return normalize(direction)
}

func getNormalPointFrom(point:CGPoint, withNormalVector v:CGPoint, andMagnitude m:CGFloat) -> CGPoint {
    return CGPointMake(point.x + v.x * m, point.y + v.y * m)
}

func getColorFromHex(var hexValue:UInt) -> UIColor {
    if hexValue > 0xffffff {
        hexValue = 0xffffff
    }
    
    return UIColor(red: CGFloat(Double((hexValue & 0xFF0000) >> 16)/255.0), green: CGFloat(Double((hexValue & 0x00FF00) >> 8)/255.0), blue: CGFloat(Double((hexValue & 0x0000FF) >> 0)/255.0), alpha: 1)
}
