//
//  JHViewController+TouchHandler.swift
//  PaintWithCALayer
//
//  Created by Jae Hee Cho on 2015-12-05.
//  Copyright © 2015 Jae Hee Cho. All rights reserved.
//

import Foundation
import UIKit

extension JHViewController {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch?.locationInView(self.view)
        
        self.pointsIndex = 1
        
        self.bezierPoints.append(location!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var previousLocation:CGPoint
        if self.bezierPoints.count == 1 {
            previousLocation = self.bezierPoints.last!
        } else {
            previousLocation = self.bezierPoints[self.pointsIndex]
            self.bezierPoints.removeAtIndex(self.pointsIndex)
            self.controlPoints.removeRange(self.pointsIndex-1...self.pointsIndex)
        }
        
        let touch = touches.first
        let currentLocation = touch?.locationInView(self.view)
        
        let distance = distanceBetween(pointA: previousLocation, pointB: currentLocation!)
        var lineThickness = distance/10
        
        lineThickness = min(20, lineThickness)
        lineThickness = max(0.2, lineThickness)
        
        let direction = getDirectionVectorFrom(previousLocation, to: currentLocation!)
        
        let normalVector1 = CGPointMake(direction.y, -direction.x)
        
        let a = getNormalPointFrom(previousLocation, withNormalVector: normalVector1, andMagnitude: lineThickness)
        let b = getNormalPointFrom(currentLocation!, withNormalVector: normalVector1, andMagnitude: lineThickness)
        let midpoint1 = getMidpointBetween(a, and: b)
        
        let normalVector2 = CGPointMake(-direction.y, direction.x)
        
        let c = getNormalPointFrom(currentLocation!, withNormalVector: normalVector2, andMagnitude: lineThickness)
        let d = getNormalPointFrom(previousLocation, withNormalVector: normalVector2, andMagnitude: lineThickness)
        let midpoint2 = getMidpointBetween(c, and: d)
        
        let newBezierPoints:Array<CGPoint> = [midpoint1, currentLocation!, midpoint2]
        let newControlPoints:Array<CGPoint> = [a, b, c, d]
        
        if self.bezierPoints.count == 1 {
            self.bezierPoints.appendContentsOf(newBezierPoints)
            self.controlPoints.appendContentsOf(newControlPoints)
        } else {
            self.bezierPoints.insertContentsOf(newBezierPoints, at: self.pointsIndex)
            self.controlPoints.insertContentsOf(newControlPoints, at: self.pointsIndex-1)
        }
        
        self.pointsIndex++
        
        self.drawPath = UIBezierPath()
        let firstPoint = self.bezierPoints[0]
        self.drawPath.moveToPoint(firstPoint)
        
        for i in 1 ..< self.bezierPoints.count {
            let nextPoint = self.bezierPoints[i]
            let controlPoint = self.controlPoints[i-1]
            
            self.drawPath.addQuadCurveToPoint(nextPoint, controlPoint: controlPoint)
        }
        
        self.drawPath.addQuadCurveToPoint(firstPoint, controlPoint: self.controlPoints.last!)
        self.drawLayer.fillColor = self.lineColor.CGColor
        self.drawLayer.strokeColor = self.lineColor.CGColor 
        self.drawLayer.path = self.drawPath.CGPath
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.saveToCALayer()
        self.resetBezierPath()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.touchesEnded(touches!, withEvent: event)
    }
    
    func saveToCALayer() {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetBlendMode(context, CGBlendMode.Copy)
        self.view.layer.renderInContext(context!)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        self.drawLayer.renderInContext(context!)
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        
        self.view.layer.contents = tempImage.CGImage
        UIGraphicsEndImageContext()
    }
}
