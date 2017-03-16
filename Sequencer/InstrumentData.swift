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
    var tom: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var clap: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var cym: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let DEFAULT_KICK: [Int] = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
    let DEFAULT_SNARE: [Int] = [0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0]
    let DEFAULT_HIHAT: [Int] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    let DEFAULT_TOM: [Int] = [0,0,0,1,0,1,0,0,0,0,1,0,0,1,0,0]
    let DEFAULT_CLAP: [Int] = [0,0,1,0,0,0,0,1,0,0,1,0,1,0,0,0]
    let DEFAULT_CYM: [Int] = [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1]
    
    var kickSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snareSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihatSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var tomSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var clapSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var cymSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var kickSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snareSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihatSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var tomSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var clapSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var cymSavedPerformance: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    func resetData(gridArray: inout [Int], current: String) {
        
        kick = DEFAULT_KICK
        snare = DEFAULT_SNARE
        hihat = DEFAULT_HIHAT
        tom = DEFAULT_TOM
        clap = DEFAULT_CLAP
        cym = DEFAULT_CYM
        
        switch current {
            
        case "Kick":
            gridArray = kick
        case "Snare":
            gridArray = snare
        case "Hihat":
            gridArray = hihat
        case "Tom":
            gridArray = tom
        case "Clap":
            gridArray = clap
        case "Crash":
            gridArray = cym
        
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
        case "Tom":
            tom = gridArray
        case "Clap":
            clap = gridArray
        case "Crash":
            cym = gridArray
            
        default:
            break
        }
        
        kickSaved = kick
        snareSaved = snare
        hihatSaved = hihat
        tomSaved = tom
        clapSaved = clap
        cymSaved = cym
    }
    
    func savePerformance(gridArray: [Int], current: String) {
        
        switch current {
            
        case "Kick":
            kick = gridArray
        case "Snare":
            snare = gridArray
        case "Hihat":
            hihat = gridArray
        case "Tom":
            tom = gridArray
        case "Clap":
            clap = gridArray
        case "Crash":
            cym = gridArray
            
        default:
            break
        }
        
        kickSavedPerformance = kick
        snareSavedPerformance = snare
        hihatSavedPerformance = hihat
        tomSavedPerformance = tom
        clapSavedPerformance = clap
        cymSavedPerformance = cym
        
    }
    
    func loadData(gridArray: inout [Int], current: String) {
        
        kick = kickSavedPerformance
        snare = snareSavedPerformance
        hihat = hihatSavedPerformance
        tom = tomSavedPerformance
        clap = clapSavedPerformance
        cym = cymSavedPerformance
        
        switch current {
            
        case "Kick":
            gridArray = kick
        case "Snare":
            gridArray = snare
        case "Hihat":
            gridArray = hihat
        case "Tom":
            gridArray = tom
        case "Clap":
            gridArray = clap
        case "Crash":
            gridArray = cym
            
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
        case "Tom":
            gridArray = tom
        case "Clap":
            gridArray = clap
        case "Crash":
            gridArray = cym
            
        default:
            break
        }
    }
    
}
