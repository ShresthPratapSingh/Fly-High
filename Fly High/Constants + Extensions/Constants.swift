//
//  Constants.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 12/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let SCREEN_SIZE = UIScreen.main.bounds.size
    static let LIGHT_BLUE = #colorLiteral(red: 0.2677245619, green: 0.7738445278, blue: 1, alpha: 1)
    static let blueish = #colorLiteral(red: 0.08285622799, green: 0.2967253989, blue: 0.5136289673, alpha: 1)
    
    static func cloudImageNames()->[String]{
        var imageArray : [String] = []
        for i in 0...2{
            imageArray.append("clouds_0\(i+1)")
        }
        return imageArray
    }
    
}
