//
//  ReverbViewController.swift
//  Sequencer
//
//  Created by Harry Bryant on 15/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

var dryWetMixValue = 0
var reverbSelection = "Small Room"
var reverbSelectionIndex = 0
var reverbSelectedItem: WKPickerItem!
var reverbPickerList: [String]!
var reverbPickerItems: [WKPickerItem]!

class ReverbViewController: WKInterfaceController, WCSessionDelegate {
    
    // Watch Connectivity Setup
    let session = WCSession.default
    
    func initWCSession() {
        session.delegate = self
        session.activate()
    }
    internal func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        reverbPickerList = ["Small Room", "Medium Chamber", "Large Room"]
        
        let reverbPickerItems: [WKPickerItem] = reverbPickerList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "\($0)"
            pickerItem.title = "\($0)"
            return pickerItem
        }
        
        reverbPicker.setItems(reverbPickerItems)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        initWCSession()
        
        reverbPicker.setSelectedItemIndex(reverbSelectionIndex)
        reverbSlider.setValue(Float(dryWetMixValue * 10))
        reverbPicker.focus()
    }
    
//    UI Setup
    @IBOutlet var reverbLabel: WKInterfaceLabel!
    @IBOutlet var reverbPicker: WKInterfacePicker!
    @IBAction func reverbPickerValueChanged(_ value: Int) {
        
        reverbSelectionIndex = value
        reverbSelection = (reverbPickerList[value])
        
      let msg = ["value" : dryWetMixValue, "Sender": reverbSelection] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    
    @IBOutlet var reverbSlider: WKInterfaceSlider!
    @IBOutlet var DryWetMixLabel: WKInterfaceLabel!
    @IBAction func reverbSliderValueChanged(_ value: Float) {
        
        dryWetMixValue = Int(value * 0.1)
        
        let msg = ["value" : dryWetMixValue, "Sender": reverbSelection] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }

}
