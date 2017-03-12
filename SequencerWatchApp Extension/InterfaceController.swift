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


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    let session = WCSession.default()
    
    // Toggle Track Variables
    var kickState: Int = 1
    var snareState: Int = 1
    var hihatState: Int = 1
    
    // Toggle Track Function
    func toggleTrack(Type: inout Int) {
        if Type == 0 {
            Type = 1
        } else {
            Type = 0
        }
    }
    
    internal func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    
    @IBOutlet var lblCounter: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        initWCSession()
    }
    
    func initWCSession() {
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        let msg = message["ValueSentFromiPhone"] as! String
        lblCounter.setText(msg)
    }
    
    @IBAction func toggleKick() {
        
        toggleTrack(Type: &kickState)
        
        let msg = ["value" : kickState, "Sender": "Kick"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
        
    }
    
    @IBAction func toggleSnare() {
        
        toggleTrack(Type: &snareState)
        
        let msg = ["value" : snareState, "Sender": "Snare"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    @IBAction func toggleHihat() {
        
        toggleTrack(Type: &hihatState)
        
        let msg = ["value" : hihatState, "Sender": "Hihat"] as [String : Any]
        
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
}
