//
//  CategoryCellUIView.swift
//  Grocery
//
//  Created by Takasur Azeem on 23/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class CategoryCellUIView: UIView {

    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        sharedInit()
    }
    
    fileprivate func sharedInit() {
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2), radius: (frame.size.width) / 2.0, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 5.0
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        layer.addSublayer(circleLayer)
    }
    
    func animateCircle(with duration: TimeInterval, selected: Bool) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        
        animation.fromValue = selected ? 0 : 1
        animation.toValue = selected ? 1 : 0
        
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = selected ? 1.0 : 0.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }

}
