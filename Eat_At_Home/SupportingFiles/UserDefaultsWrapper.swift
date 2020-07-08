//
//  UserDefaultsWrapper.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 7/8/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

struct UserDefaultsWrapper {
    
    static let shared = UserDefaultsWrapper()
    
   private let recipeDict = "recipeDict"
    
    func store(recipeList:Dictionary<String,String>) {
        UserDefaults.standard.set(recipeList, forKey: recipeDict)
    }
    
    func getRecipeDict() -> Dictionary<String,String>? {
        UserDefaults.standard.value(forKey: recipeDict) as? Dictionary<String,String>
    }
}
