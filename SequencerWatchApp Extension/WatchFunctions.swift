//
//  WatchFunctions.swift
//  Sequencer
//
//  Created by Harry Bryant on 13/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation
import UIKit
import WatchKit

func watchRandColor() -> UIColor {
    
    let red = CGFloat(arc4random_uniform(256)) / 255.0
    let green = CGFloat(arc4random_uniform(256)) / 255.0
    let blue = CGFloat(arc4random_uniform(256)) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func toggleTrack(type: inout Int, btn: WKInterfaceButton) {
    if type == 0 {
        type = 1
        btn.setAlpha(1.0)
    } else {
        type = 0
        btn.setAlpha(0.5)
    }
}

func checkCurrentToggleState(type: Int, btn: WKInterfaceButton) {
    if type == 1 {
        btn.setAlpha(1.0)
    } else {
        btn.setAlpha(0.5)
    }
}
