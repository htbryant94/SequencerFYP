import Foundation



class InstrumentData {
    
    var kick: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snare: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihat: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    let DEFAULT_KICK: [Int] = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
    let DEFAULT_SNARE: [Int] = [0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0]
    let DEFAULT_HIHAT: [Int] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
    
    var kickSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var snareSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var hihatSaved: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    func resetData() {
        kick = DEFAULT_KICK
        snare = DEFAULT_SNARE
        hihat = DEFAULT_HIHAT
    }
    
    func saveData() {
        kickSaved = kick
        snareSaved = snare
        hihatSaved = hihat
    }
    
    func LoadData() {
        kick = kickSaved
        snare = snareSaved
        hihat = hihatSaved
    }

}
