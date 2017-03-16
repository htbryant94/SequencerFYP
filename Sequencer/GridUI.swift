//
//  GridUI.swift
//  Sequencer
//
//  Created by Harry Bryant on 05/03/2017.
//  Copyright © 2017 Harry Bryant. All rights reserved.
//

import Foundation
import UIKit


class GridUI {
    
    func updateGridState(gridArray: [Int], btnArray: [UIButton]) {
        
        for i in 0 ..< gridArray.count {
            
            if (gridArray[i] == 0) {
                
                btnArray[i].backgroundColor = UIColor.black
                btnArray[i].alpha = 0.5
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
            btnArray[step].alpha = 0.5
            gridArray[step] = 0
        }
    }

}

