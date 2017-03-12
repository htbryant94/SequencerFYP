import Foundation
import UIKit


class GridUI {
    
    func generateRandomColor() -> UIColor {
        
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func updateGridState(gridArray: [Int], btnArray: [UIButton]) {
        
        for i in 0 ..< gridArray.count {
            
            if (gridArray[i] == 0) {
                
                btnArray[i].backgroundColor = UIColor.black
                btnArray[i].alpha = 0.1
            }
            else if (gridArray[i] == 1) {
                
                btnArray[i].backgroundColor = generateRandomColor()
                btnArray[i].alpha = 1.0
            }
        }
        
    }
    
    
    func updateStepValue(gridArray: inout [Int], btnArray: [UIButton], step: Int) {
        
        if (gridArray[step] == 0) {
            
            btnArray[step].backgroundColor = generateRandomColor()
            btnArray[step].alpha = 1.0
            gridArray[step] = 1
            
        }
        else if (gridArray[step] == 1) {
            
            btnArray[step].backgroundColor = UIColor.black
            btnArray[step].alpha = 0.1
            gridArray[step] = 0
        }
    }
    
    
    
}

