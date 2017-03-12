import Foundation


class MusicSequencer {
    
    func setTempo (bpm: Double) -> UInt32 {
        let tempoConvert = 60.0 / bpm
        let IntervalBetweenBeats = UInt32(tempoConvert * 1000000)
        return IntervalBetweenBeats
    }

    
    }
    
