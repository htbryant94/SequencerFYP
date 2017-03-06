import Foundation
import UIKit


class GridUI {
    
    
    
    func updateGridState(gridArray: [Int], btnArray: [UIButton]) {
    
        for i in 0 ..< gridArray.count {
    
            if (gridArray[i] == 0) {
                
                btnArray[i].backgroundColor = UIColor.green
            }
            else if (gridArray[i] == 1) {
                
                btnArray[i].backgroundColor = UIColor.black
            }
        }
        
    }
    
    
    func updateStepValue(gridArray: inout [Int], btnArray: [UIButton], step: Int) {
        
        if (gridArray[step] == 0) {
            
            btnArray[step].backgroundColor = UIColor.black
            gridArray[step] = 1
        }
        else if (gridArray[step] == 1) {
            
            btnArray[step].backgroundColor = UIColor.green
            gridArray[step] = 0
        }
    }
    
    
    
}
