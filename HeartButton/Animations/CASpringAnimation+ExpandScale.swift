//
//  CASpringAnimation+ExpandScale.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension CASpringAnimation {
    
    /// The Expansion and bouncing animation
    static var expansionAndBouncingAnimation: CASpringAnimation {
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
