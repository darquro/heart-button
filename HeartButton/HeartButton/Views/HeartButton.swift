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
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = self
    }
}

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
