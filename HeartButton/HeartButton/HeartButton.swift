//
//  HeartButton.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        // Calculate Radius of Arcs using Pythagoras
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo) / 2
        
        // Left Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        // Top Centre Dip
        self.addLine(to: CGPoint(x: rect.width / 2, y: rect.height * 0.2))
        
        // Right Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        // Right Bottom Line
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        // Left Bottom Line
        self.close()
    }
}

@IBDesignable
public class HeartButton: UIView {
    @IBInspectable public var isOn: Bool = false {
        didSet {
            stateChanged?(self, self.isOn)
        }
    }
    @IBInspectable public var offStrokeWidth: CGFloat = 3.0
    @IBInspectable public var offStrokeColor: UIColor = UIColor.black
    @IBInspectable public var offFillColor: UIColor = UIColor.clear
    @IBInspectable public var onStrokeWidth: CGFloat = 0
    @IBInspectable public var onStrokeColor: UIColor = UIColor.clear
    @IBInspectable public var onFillColor: UIColor = UIColor.red
    
    public var stateChanged: ((HeartButton, Bool) -> Void)?
    
    private var offLayer: CAShapeLayer?
    private var onLayer: CAShapeLayer?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapHandler(gesture:))))
    }
    
    @objc private func onTapHandler(gesture: UITapGestureRecognizer) {
        if isOn {
            changeDisplayToOff(animated: true)
            isOn = false
        } else {
            changeDisplayToOn(animated: true)
            isOn = true
        }
    }
    
    override public func draw(_ rect: CGRect) {
        // Remove all layers
        if var sublayers = self.layer.sublayers {
            sublayers.removeAll()
        }
        
        // Create off layer
        let offLayer = createOffLayer()
        self.offLayer = offLayer
        
        // Create on layer
        let onLayer = createOnLayer()
        self.onLayer = onLayer
        
        if self.isOn {
            self.layer.addSublayer(offLayer)
            offLayer.isHidden = true
            self.layer.addSublayer(onLayer)
        } else {
            self.layer.addSublayer(onLayer)
            onLayer.isHidden = true
            self.layer.addSublayer(offLayer)
        }
    }
    
    public func changeState(isOn: Bool, animated: Bool) {
        self.isOn = isOn
        if isOn {
            changeDisplayToOn(animated: animated)
        } else {
            changeDisplayToOff(animated: animated)
        }
    }
    
    private func createOffLayer() -> CAShapeLayer {
        let offLayer = CAShapeLayer()
        let offPath = UIBezierPath(heartIn: self.bounds)
        offLayer.path = offPath.cgPath
        offLayer.lineWidth = offStrokeWidth
        offLayer.strokeColor = offStrokeColor.cgColor
        offLayer.fillColor = offFillColor.cgColor
        return offLayer
    }
    
    private func createOnLayer() -> CAShapeLayer {
        let onLayer = CAShapeLayer()
        let onPath = UIBezierPath(heartIn: self.bounds)
        onLayer.path = onPath.cgPath
        onLayer.lineWidth = onStrokeWidth
        onLayer.strokeColor = onStrokeColor.cgColor
        onLayer.fillColor = onFillColor.cgColor
        return onLayer
    }
    
    private func changeDisplayToOn(animated: Bool) {
        onLayer?.isHidden = false
        switchLayer()
        if animated {
            let anim = makeTransFormScaleAnimation()
            layer.add(anim, forKey: nil)
        }
        offLayer?.isHidden = true
    }
    
    private func changeDisplayToOff(animated: Bool) {
        offLayer?.isHidden = false
        switchLayer()
        if animated {
            let anim = makeTransFormScaleAnimation()
            layer.add(anim, forKey: nil)
        }
        onLayer?.isHidden = true
    }
    
    private func switchLayer() {
        guard let sublayers = self.layer.sublayers,
            sublayers.count == 2,
            let firstLayer = self.layer.sublayers?.first,
            let secondLayer = self.layer.sublayers?.last
            else {
                return
        }
        self.layer.insertSublayer(secondLayer, at: 0)
        self.layer.insertSublayer(firstLayer, at: 1)
    }
    
    private func makeTransFormScaleAnimation() -> CASpringAnimation {
        let anim = CASpringAnimation(keyPath: "transform.scale")
        anim.fromValue = 0.5
        anim.toValue = 1.0
        anim.mass = 1.0
        anim.initialVelocity = 30.0
        anim.damping = 30.0
        anim.stiffness = 120.0
        anim.duration = anim.settlingDuration
        return anim
    }
}
