//
//  Int+Radians.swift
//  HeartButton
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
