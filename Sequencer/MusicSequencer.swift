import Foundation


class MusicSequencer {
    
//    let Instrument = Instruments()
//    let Data = InstrumentData()
    
    func setTempo (bpm: Double) -> UInt32 {
        let tempoConvert = 60.0 / bpm
        let IntervalBetweenBeats = UInt32(tempoConvert * 1000000)
        return IntervalBetweenBeats
    }
    
//    func playSequencer(tempo: Int) {
//        
//            for i in 0...15 {
//                
//                if Data.kick[i] == 1 && i % 2 == 0 {
//                    Instrument.kickPlayer.play()
//                    
//                }
//                else if Data.kick[i] == 1 {
//                    Instrument.kickPlayer2.play()
//                }
//                if Data.snare[i] == 1 {
//                    Instrument.snarePlayer.play()
//                }
//                if Data.hihat[i] == 1 {
//                    Instrument.hihatPlayer.play()
//                }
//                usleep(setTempo(bpm: tempo))
//            }
//    }
    
    
    }
    
