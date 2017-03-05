
import UIKit
import AudioKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var buttons: [UIButton] = [UIButton]()
    var grid = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    var defaultSteps: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    // Instrument Data Arrays
    var snareSteps: [Int] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    var kickSteps: [Int] = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
    var hihatSteps: [Int] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    
    // Use variable names that are relevant to the type your using. e.g. kickPlayer instead of kick. I find it helps with trying to figure out what methods they hold.
    
    var kickPlayer: AKAudioPlayer!
    var kickPlayer2: AKAudioPlayer!
    var snarePlayer: AKAudioPlayer!
    var hihatPlayer: AKAudioPlayer!
    
    
    func updateGridState() {
        
        for x in 0 ..< buttonArray.count {
            
            if(grid[x] == 0) {
                
                buttonArray[x].backgroundColor = UIColor.green
                
            } else if(grid[x] == 1) {
                
                buttonArray[x].backgroundColor = UIColor.black
                
            }
        }
        
    }
    
    // Variables
    var startLoop = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Append buttons from buttonArray to buttons based on the number of buttons in the Outlet Collection
        for x in 0 ..< buttonArray.count {
            self.buttons.append(self.buttonArray[x])
        }
        
        let kickfile = try! AKAudioFile(readFileName: "EDMkick.mp3", baseDir: .resources)
        let kickfile2 = try! AKAudioFile(readFileName: "EDMkick.mp3", baseDir: .resources)
        let snarefile = try! AKAudioFile(readFileName: "danceSnare.mp3", baseDir: .resources)
        let hihatfile = try! AKAudioFile(readFileName: "hihat.aif", baseDir: .resources)
        
        
        kickPlayer  = try! AKAudioPlayer(file: kickfile)
        kickPlayer2  = try! AKAudioPlayer(file: kickfile2)
        snarePlayer = try! AKAudioPlayer(file: snarefile)
        hihatPlayer = try! AKAudioPlayer(file: hihatfile)
        
        let mixer = AKMixer(kickPlayer,kickPlayer2, snarePlayer, hihatPlayer)
        
        AudioKit.output = mixer
        AudioKit.start()
        
    }
    
    
    
    // function to set tempo of Sequencer
    func tempo (bpm: Int) -> UInt32 {
        let tempoConvert = 60.0 / bpm
        let IntervalBetweenBeats = UInt32(tempoConvert * 1000000)
        return IntervalBetweenBeats
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
    
    @IBOutlet weak var button: UIButton!
    @IBAction func playSound(_ sender: AnyObject) {
        
        
        
        //DispatchQueue.global(qos: .background).async {
        
        
        repeat {
            for i in 0...15 {
                
                if kickSteps[i] == 1 && i % 2 == 0 {
                    kickPlayer.play()
                    
                } else if kickSteps[i] == 1 {
                    kickPlayer2.play()
                }
                if snareSteps[i] == 1 {
                    snarePlayer.play()
                }
                if hihatSteps[i] == 1 {
                    hihatPlayer.play()
                }
                usleep(tempo(bpm: 128))
            }
        } while startLoop == true
        
        
        //}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picker View Stuff
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    var mode = ["Kick", "Snare"]
    
    
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
        
        //let previousSelection = mode[row]
        
        label.text = mode[row]
        
        if(mode[row] == "Snare") {
            
            print("Snare Mode Selected")
            //print("Previous Selection: \(previousSelection)")
            
            for x in 0 ..< 16 {
                grid[x] = snareSteps[x]
                
                updateGridState()
            }
            
        } else if(mode[row] == "Kick") {
            
            print("Kick Mode Selected")
            //print("Previous Selection: \(previousSelection)")
            
            for x in 0 ..< 16 {
                grid[x] = kickSteps[x]
                
                updateGridState()
            }
   
        }
    } // End Picker Stuff
    
    // Grid Stuff
    
    @IBAction func checkButtonArray(_ sender: AnyObject) {
        
        updateGridState()
    }
    
    @IBAction func SaveArray(_ sender: AnyObject) {
        if(label.text == "Snare") {
            for x in 0 ..< 16 {
                snareSteps[x] = grid[x]
                print("snareSteps \(x) is now: \(snareSteps[x])")
            }
        } else if(label.text == "Kick") {
            for x in 0 ..< 16 {
                kickSteps[x] = grid[x]
                print("kickSteps \(x) is now: \(kickSteps[x])")
            }
        }
    }
    
    @IBAction func changeButtonState(_ sender: AnyObject) {
        var value = (sender as! UIButton).tag
        value = value - 1
        
        if grid[value] == 0 {
            
            buttonArray[value].backgroundColor = UIColor.black
            grid[value] = 1
            
        } else if(grid[value] == 1) {
            
            buttonArray[value].backgroundColor = UIColor.green
            grid[value] = 0
        }
        
    }
    
    
    @IBAction func checkArray(_ sender: AnyObject) {
        for x in 0 ..< grid.count {
            print(grid[x])
        }
    }
    
    // Create Array of Buttons and store in Outlet Collection
    @IBOutlet var buttonArray: [UIButton]!
    
}

