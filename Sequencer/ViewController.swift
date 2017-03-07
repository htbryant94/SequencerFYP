
import UIKit
import AudioKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var buttons: [UIButton] = [UIButton]()
    var grid = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var defaultSteps: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    // Initialise Classes
    let Instrument = Instruments()
    let Grid = GridUI()
    let Data = InstrumentData()
    let Sequencer = MusicSequencer()
    
    // Variables
    var startLoop = false
    var currentInstrumentSelection = "Nil"
    var highPassFilter: AKHighPassFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempoLabel.text = String(tempoSlider.value)
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
        
        
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
    
    @IBOutlet weak var loopState: UILabel!
    @IBAction func toggleLoop(_ sender: UISwitch) {
        
        if sender.isOn == true {
            loopState.text = "Looping: On"
            startLoop = true
        } else {
            loopState.text = "Looping: Off"
            startLoop = false
        }
    }
    
    
    func playSequencer() {
        
        repeat {
            for i in 0...15 {
                
                if Data.kick[i] == 1 && i % 2 == 0 {
                    Instrument.kickPlayer.play()
                    
                } else if Data.kick[i] == 1 {
                    Instrument.kickPlayer2.play()
                }
                if Data.snare[i] == 1 {
                    Instrument.snarePlayer.play()
                }
                if Data.hihat[i] == 1 {
                    Instrument.hihatPlayer.play()
                }
                usleep(Sequencer.setTempo(bpm: Double(tempoSlider.value)))
            }
        } while startLoop == true
        
    }
    
   
    
    
    @IBOutlet weak var button: UIButton!
    @IBAction func playSound(_ sender: AnyObject) {
        
        playSequencer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picker View Stuff
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
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
        
        label.text = mode[row]
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
    
    @IBAction func checkButtonArray(_ sender: AnyObject) {
        
        Grid.updateGridState(gridArray: grid, btnArray: buttonArray)
    }
    
    @IBAction func SaveArray(_ sender: AnyObject) {

        switch currentInstrumentSelection {
            
        case "Snare":
            
            for x in 0 ..< 16 {
                Data.snare[x] = grid[x]
                print("snareSteps \(x) is now: \(Data.snare[x])")
            }
        case "Kick":
            
            for x in 0 ..< 16 {
                
                Data.kick[x] = grid[x]
                print("kickSteps \(x) is now: \(Data.kick[x])")
            }
        case "Hihat":
            
            for x in 0 ..< 16 {
                
                Data.hihat[x] = grid[x]
                print("hihatSteps \(x) is now: \(Data.hihat[x])")
            }
        default:
            print("No Intrument Selected")
            
        }
    }
    
    @IBAction func changeButtonState(_ sender: AnyObject) {
        
        var value = (sender as! UIButton).tag
        value = value - 1
        Grid.updateStepValue(gridArray: &grid, btnArray: buttonArray, step: value)
    }
    
    @IBAction func checkArray(_ sender: AnyObject) {
        for x in 0 ..< grid.count {
            print(grid[x])
        }
    }
    
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBAction func changeSliderValue(_ sender: Any) {
        tempoLabel.text = String(tempoSlider.value)
    }
    
    @IBOutlet weak var filterSlider: UISlider!
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBAction func changeFilterValue(_ sender: Any) {
        filterLabel.text = String(filterSlider.value)
        highPassFilter.cutoffFrequency = Double(filterSlider.value)
        
    }
    
    
    // Create Array of Buttons and store in Outlet Collection
    @IBOutlet var buttonArray: [UIButton]!
    
}

