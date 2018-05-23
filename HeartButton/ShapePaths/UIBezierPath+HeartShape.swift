//
//  UIBezierPath+HeartShape.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension UIBezierPath {

    /// Create heart path
    ///
    /// - Parameter rect: draw in the rect
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        let bottomCenter = CGPoint(x: rect.width * 0.5, y: rect.height)
        let topCenter = CGPoint(x: rect.width * 0.5, y: rect.height * 0.25)
        let leftSideControl = CGPoint(x: -(rect.width * 0.45), y: (rect.height * 0.45))
        let leftTopControl = CGPoint(x: (rect.width * 0.25), y: -(rect.height * 0.2))
        let rightTopControl = CGPoint(x: rect.width - leftTopControl.x, y: leftTopControl.y)
        let rightSideControl = CGPoint(x: rect.width + (leftSideControl.x * -1), y: leftSideControl.y)
        
        self.move(to: bottomCenter)
        
        // Left Side Curve
        self.addCurve(to: topCenter,
                      controlPoint1: leftSideControl,
                      controlPoint2: leftTopControl)
        
        // Right Side Curve
        self.addCurve(to: bottomCenter,
                      controlPoint1: rightTopControl,
                      controlPoint2: rightSideControl)
        
        self.close()
    }
}
