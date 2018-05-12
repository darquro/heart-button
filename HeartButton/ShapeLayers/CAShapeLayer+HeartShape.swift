//
//  CAShapeLayer+HeartShape.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension CAShapeLayer {
    
    /// Create heart shape layer
    ///
    /// - Parameters:
    ///   - rect: draw in the rect
    ///   - lineWidth: used to line width
    ///   - lineColor: used to line color
    ///   - fillColor: used to fill color
    convenience init(heartIn rect: CGRect,
                     lineWidth: CGFloat,
                     lineColor: UIColor,
                     fillColor: UIColor) {
        self.init()
        let path = UIBezierPath(heartIn: rect)
        self.path = path.cgPath
        self.lineWidth = lineWidth
        self.strokeColor = lineColor.cgColor
        self.fillColor = fillColor.cgColor
    }
}
