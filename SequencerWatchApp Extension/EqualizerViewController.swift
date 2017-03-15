//
//  EqualizerViewController.swift
//  Sequencer
//
//  Created by Harry Bryant on 15/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

var bassGain: Int = 0
var midGain: Int = 0
var trebleGain: Int = 0

class EqualizerViewController: WKInterfaceController, WCSessionDelegate {
    
    // Watch Connectivity Setup
    let session = WCSession.default()
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
        
        
        bassSlider.setValue(Float(bassGain * 10))
        midSlider.setValue(Float(midGain * 10))
        trebleSlider.setValue(Float(trebleGain * 10))
    }
    
    
//    UI Setup
    
    @IBOutlet var bassSlider: WKInterfaceSlider!
    @IBAction func bassSliderValueChanged(_ value: Float) {
        
        bassGain = Int(value * 0.1)
        
        
        let msg = ["value" : bassGain, "Sender": "bassEQ"] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var midSlider: WKInterfaceSlider!
    @IBAction func midSliderValueChanged(_ value: Float) {
        
        midGain = Int(value * 0.1)
        
        
        let msg = ["value" : midGain, "Sender": "midEQ"] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var trebleSlider: WKInterfaceSlider!
    @IBAction func trebleSliderValueChanged(_ value: Float) {
        
        trebleGain = Int(value * 0.1)
        
        
        let msg = ["value" : trebleGain, "Sender": "trebleEQ"] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    


}
