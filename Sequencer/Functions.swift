//
//  ExperimentalFile.swift
//  Sequencer
//
//  Created by Harry Bryant on 13/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation
import UIKit

func toggleInstrument(input: String, state: Int) {
    
    switch input {
        
    case "Kick":
        Instrument.kickPlayer.volume = Double(state)
    case "Snare":
        Instrument.snarePlayer.volume = Double(state)
    case "Hihat":
        Instrument.hihatPlayer.volume = Double(state)
    case "Filter":
        highPassFilter.cutoffFrequency = Double(state)
    default:
        break
    } // end switch
}

func generateRandomColor() -> UIColor {
    
    let red = CGFloat(arc4random_uniform(256)) / 255.0
    let green = CGFloat(arc4random_uniform(256)) / 255.0
    let blue = CGFloat(arc4random_uniform(256)) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

