//
//  WatchFunctions.swift
//  Sequencer
//
//  Created by Harry Bryant on 13/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation
import UIKit

func watchRandColor() -> UIColor {
    
    let red = CGFloat(arc4random_uniform(256)) / 255.0
    let green = CGFloat(arc4random_uniform(256)) / 255.0
    let blue = CGFloat(arc4random_uniform(256)) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
