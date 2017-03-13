//
//  InstrumentData.swift
//  Sequencer
//
//  Created by Harry Bryant on 05/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation

class InstrumentData {
    
    var kick: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snare: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihat: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let DEFAULT_KICK: [Int] = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
    let DEFAULT_SNARE: [Int] = [0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0]
    let DEFAULT_HIHAT: [Int] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    
    var kickSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snareSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihatSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    func resetData(gridArray: inout [Int], current: String) {
        
        kick = DEFAULT_KICK
        snare = DEFAULT_SNARE
        hihat = DEFAULT_HIHAT
        
        switch current {
            
        case "Kick":
            gridArray = kick
        case "Snare":
            gridArray = snare
        case "Hihat":
            gridArray = hihat
            
        default:
            break
        }
    }
    
    func saveData(gridArray: [Int], current: String) {
        
        switch current {
            
        case "Kick":
            kick = gridArray
        case "Snare":
            snare = gridArray
        case "Hihat":
            hihat = gridArray
            
        default:
            break
        }
        
        kickSaved = kick
        snareSaved = snare
        hihatSaved = hihat
    }
    
    func loadData(gridArray: inout [Int], current: String) {
        
        kick = kickSaved
        snare = snareSaved
        hihat = hihatSaved
        
        switch current {
            
        case "Kick":
            gridArray = kick
        case "Snare":
            gridArray = snare
        case "Hihat":
            gridArray = hihat
            
        default:
            break
        }
    }
    
    func loadCurrentToGrid(gridArray: inout [Int], current: String) {
        
        switch current {
            
        case "Kick":
            gridArray = kick
        case "Snare":
            gridArray = snare
        case "Hihat":
            gridArray = hihat
            
        default:
            break
        }
    }
    
}
