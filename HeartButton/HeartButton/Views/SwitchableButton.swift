//
//  SwitchableButton.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

// MARK: SwitchableButtonProtocol

protocol SwitchableButtonProtocol {
    func switchableButtonOffLayer() -> CAShapeLayer
    func switchableButtonOnLayer() -> CAShapeLayer
}

// MARK: SwitchableButton

@IBDesignable
public class SwitchableButton: UIView {
    
    /// The off/on state.
    @IBInspectable public var isOn: Bool = false {
        didSet {
            if oldValue != self.isOn {
                self.stateChanged?(self, self.isOn)
            }
        }
    }

    /// The value used to line width of off state shape.
    @IBInspectable public var offLineWidth: CGFloat = 3.0
    
    /// The color used to line stroke of off state shape.
    @IBInspectable public var offLineColor: UIColor = UIColor.black
    
    /// The color used to fill of off state shape.
    @IBInspectable public var offFillColor: UIColor = UIColor.clear
    
    /// The value used to line width of on state shape.
    @IBInspectable public var onLineWidth: CGFloat = 0
    
    /// The color used to line stroke of on state shape.
    @IBInspectable public var onLineColor: UIColor = UIColor.clear
    
    /// The color used to fill of on state shape.
    @IBInspectable public var onFillColor: UIColor = UIColor.red
    
    /// The closure to handle when state changes.
    public var stateChanged: ((Any, Bool) -> Void)?
    
    /// The animation used to transitioning from on to off.
    public var offAnimations: [CAAnimation?] = [CASpringAnimation.expandScaleAnimation]
    
    /// The animation used to transitioning from off to on.
    public var onAnimations: [CAAnimation?] = [CASpringAnimation.expandScaleAnimation]
    
    /// The reference of SwitchableButtonProtocol.
    internal var delegate: SwitchableButtonProtocol?
    
    /// The off state layer.
    private var offLayer: CAShapeLayer?
    
    /// The on state layer.
    private var onLayer: CAShapeLayer?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    /// Setup view
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:))))
    }
    
    /// handle on tap gesture
    ///
    /// - Parameter gesture: tap gesture recognizer
    @objc private func handleTapGesture(gesture: UITapGestureRecognizer) {
        if isOn {
            self.changeDisplayToOff(animated: true)
            self.isOn = false
        } else {
            self.changeDisplayToOn(animated: true)
            self.isOn = true
        }
    }
    
    override public func draw(_ rect: CGRect) {
        // Remove all layers
        if var sublayers = self.layer.sublayers {
            sublayers.removeAll()
        }
        
        // Create off layer
        guard let offLayer = self.delegate?.switchableButtonOffLayer() else {
            return
        }
        self.offLayer = offLayer
        
        // Create on layer
        guard let onLayer = self.delegate?.switchableButtonOnLayer() else {
            return
        }
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
    
    public func setOn(_ isOn: Bool, animated: Bool) {
        self.isOn = isOn
        if isOn {
            self.changeDisplayToOn(animated: animated)
        } else {
            self.changeDisplayToOff(animated: animated)
        }
    }
    
    private func changeDisplayToOn(animated: Bool) {
        onLayer?.isHidden = false
        switchLayer()
        if animated {
            let animGroup = CAAnimationGroup()
            animGroup.animations = self.onAnimations.compactMap { $0 }
            layer.add(animGroup, forKey: nil)
        }
        offLayer?.isHidden = true
    }
    
    private func changeDisplayToOff(animated: Bool) {
        offLayer?.isHidden = false
        switchLayer()
        if animated {
            let animGroup = CAAnimationGroup()
            animGroup.animations = self.offAnimations.compactMap { $0 }
            layer.add(animGroup, forKey: nil)
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
}
