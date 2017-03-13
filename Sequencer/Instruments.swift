//
//  Instruments.swift
//  Sequencer
//
//  Created by Harry Bryant on 05/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation
import AudioKit



class Instruments {

    var kickPlayer: AKAudioPlayer!
    var snarePlayer: AKAudioPlayer!
    var hihatPlayer: AKAudioPlayer!
    var tomPlayer: AKAudioPlayer!
    var clapPlayer: AKAudioPlayer!
    var cymPlayer: AKAudioPlayer!

    let kickfile = try! AKAudioFile(readFileName: "kickSample.wav", baseDir: .resources)
    let snarefile = try! AKAudioFile(readFileName: "snareSample.wav", baseDir: .resources)
    let hihatfile = try! AKAudioFile(readFileName: "hihatSample.wav", baseDir: .resources)
    let tomfile = try! AKAudioFile(readFileName: "tomSample.wav", baseDir: .resources)
    let clapfile = try! AKAudioFile(readFileName: "clapSample.wav", baseDir: .resources)
    let cymfile = try! AKAudioFile(readFileName: "cymSample.wav", baseDir: .resources)
    
        }


