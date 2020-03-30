//
//  DishTypes.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/29/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

struct URLFilters  {
   let listOfDishTypes:[String] = ["main+course,","side+dish,","dessert,","appetizer,","salad,","bread,","breakfast,","soup,","beverage,","sauce,","marinade,","fingerfood,","snack,","drink,"]
    let listOfcuisines:[String] = ["African,","American,","British","Cajun,","Caribbean","Chinese,","Eastern+European,","European,","French,","German,","Greek,","Indian,","Irish,","Italian,","Japanese,","Jewish,","Korean,","Latin+American,","Mediterranean,","Mexican,","Middle+Eastern,","Nordic,","Southern,","Spanish,","Thai,","Vietnamese,"]
    
    
   let listOfFilters:[String] = ["Diet","Intolerances","Exclude Ingredients","Include Ingredients","Max Ready Time","Max Calories"]
    let listOfDiets:[String] = ["Gluten+Free,","Ketogenic,","Vegetarian,","Lacto-Vegetarian,","Ovo-Vegetarian,","Vegan,","Pescetarian,","Paleo,","Primal,","Whole30,"]
        
    let listOfIntolerances:[String] = ["Dairy,","Egg,","Gluten,","Grain,","Peanut,","Seafood,","Sesame,","Shellfish,","Soy,","Sulfite,","Tree+Nut,","Wheat,"]
    
  private var excludeIngredients:[String] = []
    
   private var includeIngredients:[String] = []
    
   private var maxReadyTime:Int = 1000
    
   private var maxCalories:Int = 500000
    
   private var dishTypes:[String] = ["&type="]
    
   private var cuisines:[String] = ["&cuisine="]
    
   private var diets:[String] = ["&diet="]
    
   private var intolerances:[String] = ["&intolerances="]
    
    mutating func addDishType(newType:String) {
        dishTypes.append(newType)
    }
    
    mutating func removeDishType(dishType:String) {
       dishTypes = dishTypes.filter({$0 != dishType})
    }
    
    mutating func addCuisine(newCuisine:String) {
        cuisines.append(newCuisine)
    }
    
    mutating func removeCuisine(cuisine:String) {
        cuisines = cuisines.filter({$0 != cuisine})
    }
    mutating func addDiet(newDiet:String) {
        diets.append(newDiet)
    }
    
    mutating func removeDiet(diet:String) {
        diets =  diets.filter({$0 != diet})
    }
    mutating func addIntolerance(newIntolerance:String) {
        intolerances.append(newIntolerance)
    }
    
    mutating func changeMaxReadyTime(newMaxReadyTime:Int) {
        maxReadyTime = newMaxReadyTime
    }
    
    mutating func changeMaxCalories(newMaxCalories:Int) {
        maxCalories = newMaxCalories
    }
    
    mutating func returnDishTypes() -> String {
      return dishTypes.joined()
    }
    
    mutating func returnCuisines() -> String {
        return cuisines.joined()
    }
    mutating func returnDiets() -> String {
        return diets.joined()
    }
    
    mutating func returnIntolerances() -> String {
        return intolerances.joined()
    }
    
    mutating func returnMaxCalories() -> String {
    return "&maxCalories=\(maxCalories)"
    }
    
    mutating func returnMaxReadyTime() -> String {
        return "&maxReadyTime=\(maxReadyTime)"
    }
}
