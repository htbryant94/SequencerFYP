//
//  SecondInterfaceController.swift
//  Sequencer
//
//  Created by Harry Bryant on 12/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

var filterValue = 0
var savedFilterValue: Int!
var pickedItem: WKPickerItem!

class SecondInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // Watch Session
    let session = WCSession.default()
    
    internal func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    
    func initWCSession() {
        session.delegate = self
        session.activate()
    }
    
    @IBOutlet var filterSlider: WKInterfaceSlider!
    @IBAction func filterSliderChanged(_ value: Int) {
        let stringValue = String(value)
        self.filterLabel.setText(stringValue)
        filterValue = value
        
        let msg = ["value" : filterValue, "Sender": "Filter"] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var picker: WKInterfacePicker!
    var pickerItems: [WKPickerItem]?
    @IBAction func pickerChanged(_ value: Int) {
        
        pickedItem = pickerItems![value]
        if let pickedValue = Int(pickedItem.title!) {
            filterValue = pickedValue * 200
            filterLabel.setText(String(filterValue))
            filterSlider.setValue(Float(filterValue))
        }
        
        let msg = ["value" : filterValue, "Sender": "Filter"] as [String : Any]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBOutlet var filterLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        pickerItems = (0...50).map {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0)"
            return pickerItem
        }
        
        picker.setItems(pickerItems)
        picker.focus()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        initWCSession()
        filterLabel.setText(String(filterValue))
        filterSlider.setValue(Float(filterValue))
        picker.setSelectedItemIndex(filterValue / 200)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
