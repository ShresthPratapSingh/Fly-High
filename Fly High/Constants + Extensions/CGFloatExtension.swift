//
//  CGFloat+Extension.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 12/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat{
    static func random()->CGFloat{
        return CGFloat(Float(arc4random())/Float(UINT32_MAX))
    }
    
    static func random (min min : CGFloat, max max : CGFloat)->CGFloat{
        assert(min<max)
        return CGFloat.random()*(max-min) + min
    }
}
