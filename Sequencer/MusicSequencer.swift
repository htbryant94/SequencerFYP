//
//  MusicSequencer.swift
//  Sequencer
//
//  Created by Harry Bryant on 05/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation

class MusicSequencer {
    
    func setTempo (bpm: Double) -> UInt32 {
        let tempoConvert = 60.0 / bpm
        let IntervalBetweenBeats = UInt32(tempoConvert * 1000000)
        return IntervalBetweenBeats
    }

    
    }
    
