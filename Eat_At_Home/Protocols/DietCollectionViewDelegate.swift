//
//  DietCollectionViewDelegate.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/30/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

protocol DietCollectionViewDelegate:AnyObject {
    func sendDietSelection(diet:String,isAdding:Bool)
}
