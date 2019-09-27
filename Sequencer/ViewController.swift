//
//  ViewController.swift
//  Sequencer
//
//  Created by Harry Bryant on 05/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import UIKit
import AudioKit
import AVFoundation
import WatchConnectivity

let Instrument = Instruments()
var highPassFilter: AKHighPassFilter!
var bassEQ: AKEqualizerFilter!
var midEQ: AKEqualizerFilter!
var trebleEQ: AKEqualizerFilter!
var Reverb: AKReverb!

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, WCSessionDelegate {
    
    
//    Start of WatchConnectivity
    
    let session = WCSession.default
    
    internal func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func initWCSession() {
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        DispatchQueue.main.async {
            let inputValue = message["value"] as! Int
            let inputSource = message["Sender"] as! String
            sentFromWatch(input: inputSource, state: inputValue)
        }
    }
    
//    End of WatchConnectivity
    
    var buttons: [UIButton] = [UIButton]()
    var grid = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var defaultSteps: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
//     Start of Timer
    var stepCounter = 0
    var timer = Timer()
    var timerTempo: Double = 0.0
    var timerIsPlaying = false

    func TimerStart() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timerTempo, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timerIsPlaying = true
    }
    
    func TimerStop() {
        timer.invalidate()
        timerIsPlaying = false
    }
    
    @objc func timerAction() {
        
        if Data.kick[stepCounter] == 1 {
            Instrument.kickPlayer.play()
        }
        if Data.snare[stepCounter] == 1 {
            Instrument.snarePlayer.play()
        }
        if Data.hihat[stepCounter] == 1 {
            Instrument.hihatPlayer.play()
        }
        if Data.tom[stepCounter] == 1 {
            Instrument.tomPlayer.play()
        }
        if Data.clap[stepCounter] == 1 {
            Instrument.clapPlayer.play()
        }
        if Data.cym[stepCounter] == 1 {
            Instrument.cymPlayer.play()
        }
        
        if stepCounter < 15 {
            
            stepCounter += 1
            buttonArray[stepCounter].alpha = 0.5
            buttonArray[stepCounter-1].alpha = 1.0
        } else {
            
            stepCounter = 0
            buttonArray[stepCounter].alpha = 0.5
            buttonArray[15].alpha = 1.0
        }
    }
//    End of Timer
    
    
    // Initialise Classes
    let Grid = GridUI()
    let Data = InstrumentData()
    
    // Variables
    var startLoop = false
    var currentInstrumentSelection = "Kick"
    
    // Setup of PickerView
    
    @IBOutlet weak var picker: UIPickerView!
    
    var mode = ["Kick", "Snare", "Hihat", "Tom", "Clap", "Crash"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = mode[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Avenir Next", size: 20.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentInstrumentSelection = mode[row]
        
        Data.loadCurrentToGrid(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
        
    } // End of PickerView

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DATA IS INITIALISED HERE UPON APP LAUNCH
        
        // Disable Application Sleep after inactivity
        UIApplication.shared.isIdleTimerDisabled = true
        
        initWCSession()
        
        
        // Setup and load default data
        Data.savePerformance(gridArray: grid, current: currentInstrumentSelection)
        tempoLabel.text = "\(String(Int(tempoSlider.value / 2))) BPM"
        picker.selectRow(0, inComponent: 0, animated: true)
        timerTempo = 60.0 / Double(round(tempoSlider.value))
        Data.resetData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
        
        //Append buttons from buttonArray to buttons based on the number of buttons in the Outlet Collection
        for x in 0 ..< buttonArray.count {
            self.buttons.append(self.buttonArray[x])
        }
        
        // Initialise Instruments
        Instrument.kickPlayer  = try! AKAudioPlayer(file: Instrument.kickfile)
        Instrument.snarePlayer = try! AKAudioPlayer(file: Instrument.snarefile)
        Instrument.hihatPlayer = try! AKAudioPlayer(file: Instrument.hihatfile)
        Instrument.tomPlayer = try! AKAudioPlayer(file: Instrument.tomfile)
        Instrument.clapPlayer = try! AKAudioPlayer(file: Instrument.clapfile)
        Instrument.cymPlayer = try! AKAudioPlayer(file: Instrument.cymfile)
        
        let mixer = AKMixer(Instrument.kickPlayer, Instrument.snarePlayer, Instrument.hihatPlayer, Instrument.tomPlayer, Instrument.clapPlayer, Instrument.cymPlayer)
        
        // Initialise HPF Settings
        highPassFilter = AKHighPassFilter(mixer)
        highPassFilter.cutoffFrequency = 0 // Hz
        highPassFilter.resonance = 0 // dB
        
        // Initialise Equalizer Settings
        bassEQ = AKEqualizerFilter(highPassFilter, centerFrequency: 50, bandwidth: 100, gain: 1.0)
        midEQ = AKEqualizerFilter(bassEQ, centerFrequency: 350, bandwidth: 300, gain: 1.0)
        trebleEQ = AKEqualizerFilter(midEQ, centerFrequency: 5000, bandwidth: 1000, gain: 1.0)
        
        // Initialise Reverb Settings
        Reverb = AKReverb(trebleEQ)
        Reverb.dryWetMix = 0.0
        
        Instrument.hihatPlayer.volume = 0.25
        Instrument.clapPlayer.volume = 0.5
        Instrument.cymPlayer.volume = 0.1
        
        AudioKit.output = Reverb
        try! AudioKit.start()
    }
    
    
    @IBOutlet weak var button: UIButton!
    @IBAction func playSound(_ sender: AnyObject) {
        
        if timerIsPlaying == false {
            TimerStart()
            self.button.setImage(UIImage(named:"Pause.png"), for: .normal)
        } else {
            TimerStop()
            self.button.setImage(UIImage(named:"Play.png"), for: .normal)
        }
        
        if stepCounter == 0 {
            buttonArray[0].alpha = 0.5
        }
    }
    
    @IBAction func changeButtonState(_ sender: AnyObject) {
        
        var value = (sender as! UIButton).tag
        value = value - 1
        Grid.updateStepValue(gridArray: &grid, btnArray: buttonArray, step: value)
        Data.saveData(gridArray: grid, current: currentInstrumentSelection)
    }
    
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBAction func changeSliderValue(_ sender: Any) {
        
        let tempoLabelValue = String(Int(tempoSlider.value / 2))
        tempoLabel.text = "\(tempoLabelValue) BPM"
        timerTempo = 60.0 / Double(round(tempoSlider.value))
        
        if timerIsPlaying == false {
            TimerStart()
            button.setImage(UIImage(named:"Pause.png"), for: .normal)
        } else {
            TimerStop()
            TimerStart()
        }
    }
    
    
    @IBAction func resetUserInput(_ sender: Any) {
        
        Data.resetData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
        stepCounter = 0
    }
    
    @IBAction func saveUserInput(_ sender: Any) {
        Data.savePerformance(gridArray: grid, current: currentInstrumentSelection)
    }
    
    @IBAction func loadUserInput(_ sender: Any) {
        
        Data.loadData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
    }

    // Create Array of Buttons and store in Outlet Collection
    @IBOutlet var buttonArray: [UIButton]!
    
}

