//
//  UserDefaultsWrapper.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

struct UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    
 
    private let excludeIngredients:String = "excludeIngredients"
    private let includeIngredients:String = "excludeIngredients"
    private let readyTime:String = "readyTime"
    private let calories:String = "calories"
    private let dishTypes:String = "dishTypes"
    private let diets:String = "diets"
    private let intolerances:String = "intolerances"
    
    func store(excludeIngredient:[String]) {
        UserDefaults.standard.set(excludeIngredient, forKey: excludeIngredients)
    }
    
    func store(includeIngredient:[String]) {
          UserDefaults.standard.set(includeIngredient, forKey: includeIngredients)
      }
    
    func store(time:String) {
          UserDefaults.standard.set(time, forKey: readyTime)
      }
    
    func store(calorie:String) {
          UserDefaults.standard.set(calorie, forKey: calories)
      }
    
    func store(dishType:[String]) {
          UserDefaults.standard.set(dishType, forKey: dishTypes)
      }
    
    func store(diet:[String]) {
          UserDefaults.standard.set(diet, forKey: diets)
      }
    
    func store(intolerance:[String]) {
          UserDefaults.standard.set(intolerance, forKey: intolerances)
      }
    
    func returnIntolerance() -> [String]? {
        UserDefaults.standard.value(forKey: intolerances) as? [String]
    }
    
    func returnDiet() -> [String]? {
        UserDefaults.standard.value(forKey: diets) as? [String]
    }
    
}

/*
 private var excludeIngredients:[String] = ["&excludeIngredients="]
    
   private var includeIngredients:[String] = ["&includeIngredients="]
    
   private var maxReadyTime:Int = 1000
    
   private var maxCalories:Int = 500000
    
   private var dishTypes:[String] = ["&type="]
    
   private var cuisines:[String] = ["&cuisine="]
    
   private var diets:[String] = ["&diet="]
    
   private var intolerances:[String] = ["&intolerances="]
 */
