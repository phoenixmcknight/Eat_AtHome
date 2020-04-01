//
//  File.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class RatingsModel {
    
    static let shared = RatingsModel()
    
    private func roundToTens(x : Double) -> Int {
           return 10 * Int(round(x / 10.0))
       }
    
    func returnCorrectStarImage(score:Double) -> UIImage {
        let roundedScore = roundToTens(x: score)
      
        
        switch roundedScore {
        case 100:
            return UIImage(named: "stars_5")!
        case 90:
            return UIImage(named: "stars_4half")!
        case 80:
            return UIImage(named:"stars_4")!
        case 70:
            return UIImage(named:"stars_3half")!
        case 60:
            return UIImage(named:"stars_3")!
        case 50:
            return UIImage(named:"stars_2half")!
        case 40:
            return UIImage(named:"stars_2")!
        case 30:
            return UIImage(named:"stars_1half")!
        case 20:
            return UIImage(named:"stars_1")!
        case 0:
            return UIImage(named:"stars_0")!
        default:
            return UIImage(named: "stars_0")!
        }
        
        
       
        
    }
    
    
}
