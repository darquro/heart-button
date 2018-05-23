//
//  HeartButton.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

@IBDesignable
public class HeartButton: SwitchableButton {
    
    /// The value used to line width of off state shape.
    @IBInspectable public var offLineWidth: CGFloat = 2.0
    
    /// The color used to line stroke of off state shape.
    @IBInspectable public var offLineColor: UIColor = UIColor.black
    
    /// The color used to fill of off state shape.
    @IBInspectable public var offFillColor: UIColor = UIColor.clear
    
    /// The value used to line width of on state shape.
    @IBInspectable public var onLineWidth: CGFloat = 0
    
    /// The color used to line stroke of on state shape.
    @IBInspectable public var onLineColor: UIColor = UIColor.clear
    
    /// The color used to fill of on state shape.
    @IBInspectable public var onFillColor: UIColor = UIColor(red: 0.92, green: 0.29, blue: 0.35, alpha: 1.0)
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = self
    }
}

// MARK: SwitchableButtonProtocol

extension HeartButton: SwitchableButtonProtocol {
    
    func switchableButtonOffLayer() -> CAShapeLayer {
        return CAShapeLayer(heartIn: self.bounds,
                            lineWidth: self.offLineWidth,
                            lineColor: self.offLineColor,
                            fillColor: self.offFillColor)
    }
    
    func switchableButtonOnLayer() -> CAShapeLayer {
        return CAShapeLayer(heartIn: self.bounds,
                            lineWidth: self.onLineWidth,
                            lineColor: self.onLineColor,
                            fillColor: self.onFillColor)
    }
}
