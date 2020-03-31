//
//  IncludeIngredientDelegate.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation


protocol  IncludeIngredientDelegate:AnyObject {
    func sendIngredient(isAdding:Bool,ingredient:String)
}

protocol ExcludeIngredientDelegate:AnyObject {
    func exlcudeIngredient(isAdding:Bool,ingredient:String)
}
