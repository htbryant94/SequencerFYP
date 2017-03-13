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

    // Use variable names that are relevant to the type your using. e.g. kickPlayer instead of kick. I find it helps with trying to figure out what methods they hold.

    var kickPlayer: AKAudioPlayer!
    var kickPlayer2: AKAudioPlayer!
    var snarePlayer: AKAudioPlayer!
    var hihatPlayer: AKAudioPlayer!

    let kickfile = try! AKAudioFile(readFileName: "EDMkick.mp3", baseDir: .resources)
    let snarefile = try! AKAudioFile(readFileName: "danceSnare.mp3", baseDir: .resources)
    let hihatfile = try! AKAudioFile(readFileName: "hihat.aif", baseDir: .resources)
        
        }


