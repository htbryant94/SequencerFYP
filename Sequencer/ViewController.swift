
import UIKit
import AudioKit
import AVFoundation
import WatchConnectivity

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, WCSessionDelegate {
    
    
//    Start of WatchConnectivity
    
    let session = WCSession.default()
    
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
    
    func toggleInstrument(input: String, state: Int) {
        
        switch input {
            
        case "Kick":
            Instrument.kickPlayer.volume = Double(state)
        case "Snare":
            Instrument.snarePlayer.volume = Double(state)
        case "Hihat":
            Instrument.hihatPlayer.volume = Double(state)
        case "Filter":
            highPassFilter.cutoffFrequency = Double(state)
        default:
            break
        } // end switch
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        DispatchQueue.main.async {
            let inputValue = message["value"] as! Int
            let inputSource = message["Sender"] as! String
            self.toggleInstrument(input: inputSource, state: inputValue)
        }
    }
    
//    End of WatchConnectivity
    

    
    var buttons: [UIButton] = [UIButton]()
    var grid = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var defaultSteps: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
//     Start of Timer
    var counter = 0
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
    
    func timerAction() {
       
        if Data.kick[counter] == 1 {
            Instrument.kickPlayer.play()
        }
        if Data.snare[counter] == 1 {
            Instrument.snarePlayer.play()
        }
        if Data.hihat[counter] == 1 {
            Instrument.hihatPlayer.play()
        }
        
        print(timerTempo)
        
        if counter < 15 {
            print(counter)
            counter += 1
        } else {
            counter = 0
        }
    }
    
//    End of Timer
    
//     Start of Notification Center
    
    let myNotification = Notification.Name(rawValue: "MyNotification")
    let nc = NotificationCenter.default
    
    // code block called when notification is Posted
    func catchNotification(notification:Notification) -> Void {
        
    }
    
//    End of Notification Center
    
    
    // Initialise Classes
    let Instrument = Instruments()
    let Grid = GridUI()
    let Data = InstrumentData()
    let Sequencer = MusicSequencer()
    
    // Variables
    var startLoop = false
    var currentInstrumentSelection = "Kick"
    var highPassFilter: AKHighPassFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWCSession()
        
        tempoLabel.text = String(Int(tempoSlider.value / 4))
        picker.selectRow(0, inComponent: 0, animated: true)
        timerTempo = 60.0 / Double(round(tempoSlider.value))
        Data.resetData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
        
        
        nc.addObserver(forName: myNotification, object: nil, queue: nil, using: catchNotification)
        
        //Append buttons from buttonArray to buttons based on the number of buttons in the Outlet Collection
        for x in 0 ..< buttonArray.count {
            self.buttons.append(self.buttonArray[x])
        }
        
        // Initialise Instruments
        Instrument.kickPlayer  = try! AKAudioPlayer(file: Instrument.kickfile)
        Instrument.kickPlayer2  = try! AKAudioPlayer(file: Instrument.kickfile)
        Instrument.snarePlayer = try! AKAudioPlayer(file: Instrument.snarefile)
        Instrument.hihatPlayer = try! AKAudioPlayer(file: Instrument.hihatfile)
        
        let mixer = AKMixer(Instrument.kickPlayer,Instrument.kickPlayer2, Instrument.snarePlayer, Instrument.hihatPlayer)
        
        highPassFilter = AKHighPassFilter(mixer)
        highPassFilter.cutoffFrequency = 0 // Hz
        highPassFilter.resonance = 0 // dB
        
        AudioKit.output = highPassFilter
        AudioKit.start()
        
    }
    

    @IBOutlet weak var button: UIButton!
    @IBAction func playSound(_ sender: AnyObject) {
        
        //nc.post(name: myNotification, object: nil)
        
        if timerIsPlaying == false {
            TimerStart()
        } else {
            TimerStop()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picker View Stuff
    
    @IBOutlet weak var picker: UIPickerView!
    
    var mode = ["Kick", "Snare", "Hihat"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentInstrumentSelection = mode[row]
        
        switch mode[row] {
            
        case "Snare":
            print("Snare Selected")
            for x in 0 ..< 16 {
                
            grid[x] = Data.snare[x]
            Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
            }
        case "Kick":
            print("Kick Selected")
            for x in 0 ..< 16 {
                
                grid[x] = Data.kick[x]
                Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
            }
        case "Hihat":
            print("Hihat Selected")
            for x in 0 ..< 16 {
                
                grid[x] = Data.hihat[x]
                Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
            }
        default:
            print("No Intrument Selected")
        }
      
    } // End Picker Stuff
    
    
    @IBAction func changeButtonState(_ sender: AnyObject) {
        
        var value = (sender as! UIButton).tag
        value = value - 1
        Grid.updateStepValue(gridArray: &grid, btnArray: buttonArray, step: value)
    }
    
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBAction func changeSliderValue(_ sender: Any) {
        tempoLabel.text = String(Int(tempoSlider.value / 2))
        timerTempo = 60.0 / Double(round(tempoSlider.value))
    }
    
    @IBAction func resetUserInput(_ sender: Any) {
        
        Data.resetData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
    }
    @IBAction func saveUserInput(_ sender: Any) {
        Data.saveData(gridArray: grid, current: currentInstrumentSelection)
    }
    @IBAction func loadUserInput(_ sender: Any) {
        
        Data.LoadData(gridArray: &grid, current: currentInstrumentSelection)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
    }

    // Create Array of Buttons and store in Outlet Collection
    @IBOutlet var buttonArray: [UIButton]!
    
}

