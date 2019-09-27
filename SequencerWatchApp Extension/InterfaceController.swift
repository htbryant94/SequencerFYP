//
//  InterfaceController.swift
//  SequencerWatchApp Extension
//
//  Created by Harry Bryant on 12/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

// Toggle Track Variables
var kickState: Int = 1
var snareState: Int = 1
var hihatState: Int = 1
var tomState: Int = 1
var clapState: Int = 1
var cymState: Int = 1


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    let session = WCSession.default
    
    var toggleStateArray: [Int]!
    
    @IBOutlet var filterButton: WKInterfaceButton!
    
    internal func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        func initWCSession() {
            session.delegate = self
            session.activate()
        }

        initWCSession()
        
        let trackButtonArray: [WKInterfaceButton] = [kickButton, snareButton, hihatButton, tomButton, clapButton, cymButton]
        toggleStateArray = [kickState, snareState, hihatState, tomState, clapState, cymState]
        
        for x in 0...5 {
            
            trackButtonArray[x].setBackgroundColor(watchRandColor())
            checkCurrentToggleState(type: toggleStateArray[x], btn: trackButtonArray[x])
        }
    }
    
    
    
    @IBOutlet var kickButton: WKInterfaceButton!
    @IBAction func toggleKick() {
        
        toggleTrack(type: &kickState, btn: kickButton)
        
        let msg = ["value" : kickState, "Sender": "Kick"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var snareButton: WKInterfaceButton!
    @IBAction func toggleSnare() {
        
        toggleTrack(type: &snareState, btn: snareButton)
        
        let msg = ["value" : snareState, "Sender": "Snare"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var hihatButton: WKInterfaceButton!
    @IBAction func toggleHihat() {
        
        toggleTrack(type: &hihatState, btn: hihatButton)
        
        let msg = ["value" : hihatState, "Sender": "Hihat"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var tomButton: WKInterfaceButton!
    @IBAction func toggleTom() {
        
        toggleTrack(type: &tomState, btn: tomButton)
        
        let msg = ["value" : tomState, "Sender": "Tom"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var clapButton: WKInterfaceButton!
    @IBAction func toggleClap() {
        
        toggleTrack(type: &clapState, btn: clapButton)
        
        let msg = ["value" : clapState, "Sender": "Clap"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var cymButton: WKInterfaceButton!
    @IBAction func toggleCym() {
        
        toggleTrack(type: &cymState, btn: cymButton)
        
        let msg = ["value" : cymState, "Sender": "Crash"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
}
