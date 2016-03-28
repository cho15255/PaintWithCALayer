//
//  JHViewController.swift
//  PaintWithCALayer
//
//  Created by Jae Hee Cho on 2015-12-05.
//  Copyright © 2015 Jae Hee Cho. All rights reserved.
//

import UIKit
import QuartzCore

class JHViewController: UIViewController {

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var redButton: UIBarButtonItem!
    @IBOutlet weak var yellowButton: UIBarButtonItem!
    @IBOutlet weak var greenButton: UIBarButtonItem!
    @IBOutlet weak var blueButton: UIBarButtonItem!
    @IBOutlet weak var blackButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    var lineColor:UIColor!
    var lineWidth:CGFloat!
    
    var pointsIndex:Int = 0
    
    var drawLayer:CAShapeLayer!
    var drawPath:UIBezierPath!
    var bezierPoints:Array<CGPoint>!
    var controlPoints:Array<CGPoint>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.lineColor = UIColor.blackColor()
        self.lineWidth = 0.5
        
        self.drawLayer = CAShapeLayer()
        self.drawLayer.backgroundColor = UIColor.clearColor().CGColor
        self.drawLayer.frame = self.view.frame
        
        self.drawLayer.strokeColor = self.lineColor.CGColor
        self.drawLayer.fillColor = self.lineColor.CGColor
        self.view.layer.insertSublayer(self.drawLayer, below: self.toolbar.layer)
        
        self.bezierPoints = Array<CGPoint>()
        self.controlPoints = Array<CGPoint>()
    }
    
    @IBAction func redButtonTapped(sender: AnyObject) {
        self.lineColor = UIColor.redColor()
    }
    
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        self.lineColor = UIColor.yellowColor()
    }
    
    @IBAction func greenButtonTapped(sender: AnyObject) {
        self.lineColor = UIColor.greenColor()
    }
    
    @IBAction func blueButtonTapped(sender: AnyObject) {
        self.lineColor = UIColor.blueColor()
    }
    
    @IBAction func blackButtonTapped(sender: AnyObject) {
        self.lineColor = UIColor.blackColor()
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        self.view.layer.contents = nil
        self.resetBezierPath()
    }
    
    func resetBezierPath() {
        self.drawLayer.path = nil
        self.drawPath.removeAllPoints()
        self.bezierPoints.removeAll()
        self.controlPoints.removeAll()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

