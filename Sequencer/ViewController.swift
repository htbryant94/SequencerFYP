
import UIKit
import AudioKit
import AVFoundation

class ViewController: UIViewController {
    
    
    // Instrument Data Arrays
    var snareSteps: [Int] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    var kickSteps: [Int] = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
    var hihatSteps: [Int] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    
    // Use variable names that are relevant to the type your using. e.g. kickPlayer instead of kick. I find it helps with trying to figure out what methods they hold.
    
    var kickPlayer: AKAudioPlayer!
    var kickPlayer2: AKAudioPlayer!
    var snarePlayer: AKAudioPlayer!
    var hihatPlayer: AKAudioPlayer!
    
    
    // Variables
    var startLoop = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
}

