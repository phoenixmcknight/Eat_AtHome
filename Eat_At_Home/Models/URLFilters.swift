//
//  DishTypes.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/29/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

enum Filters {
    case dishType
    case cuisine
    case diet
    case intolerance
    case excludeIngredients
    case includeIngredients
    case time
    case calories
}



struct URLFilters  {
   let listOfDishTypes:[String] = ["main+course","side+dish","dessert","appetizer","salad","bread","breakfast","soup","beverage","sauce","marinade","fingerfood","snack","drink"]
    let listOfcuisines:[String] = ["African","American","British","Cajun","Caribbean","Chinese,","Eastern+European,","European","French","German","Greek","Indian","Irish,","Italian","Japanese","Jewish","Korean","Latin+American","Mediterranean","Mexican","Middle+Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
    
    
   let listOfFilters:[String] = ["Diet","Intolerances","Exclude Ingredients","Include Ingredients","Ready Time","Max Calories"]
    let listOfDiets:[String] = ["Gluten+Free","Ketogenic","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Whole30"]
        
    let listOfIntolerances:[String] = ["Dairy","Egg","Gluten","Grain","Peanut","Seafood","Sesame","Shellfish","Soy","Sulfite","Tree+Nut","Wheat"]
    
  private var excludeIngredients:[String] = []
    
   private  var includeIngredients:[String] = []
    
   private var maxReadyTime:String?
    
   private var maxCalories:String?
    
   private  var dishTypes:[String] = []
    
   private  var cuisines:[String] = []
    
   private  var diets:[String] = []
    
   private  var intolerances:[String] = []
    

    mutating func addFilter(newStringFilter:String,newNumberFilter:Int?, filter:Filters) {
        
        switch filter {
        case .dishType:
            dishTypes.append(newStringFilter)
        case .cuisine:
            cuisines.append(newStringFilter)
        case .diet:
            diets.append(newStringFilter)
        case .intolerance:
            intolerances.append(newStringFilter)
        case .excludeIngredients:
            excludeIngredients.append(newStringFilter)
        case .includeIngredients:
            includeIngredients.append(newStringFilter)
     
        case .time:
            if let time = newNumberFilter {
                maxReadyTime = "\(time)"
            }
        case .calories:
           if let calories = newNumberFilter {
            maxCalories = "\(calories)"
                    }
        }
    }
    
    mutating func removeFilter(newStringFilter:String, filter:Filters) {
           switch filter {
               
           case .dishType:
           dishTypes = dishTypes.filter({$0 != newStringFilter})
           case .cuisine:
         cuisines = cuisines.filter({$0 != newStringFilter})
           case .diet:
               diets = diets.filter({$0 != newStringFilter})
           case .intolerance:
            intolerances = intolerances.filter({$0 != newStringFilter})
           case .excludeIngredients:
               excludeIngredients = excludeIngredients.filter({$0 != newStringFilter})
           case .includeIngredients:
               includeIngredients = includeIngredients.filter({$0 != newStringFilter})

           default:
           
            print(-1)
           }
       }
    
    public func returnFilter(filter:Filters) -> String? {
        switch filter {
            
        case .dishType:
 
            return dishTypes.joined(separator: ",")
        case .cuisine:
            return cuisines.joined(separator: ",")
        case .diet:
            return diets.joined(separator: ",")
        case .intolerance:
            return intolerances.joined(separator: ",")
        case .excludeIngredients:
            return excludeIngredients.joined(separator: ",")
        case .includeIngredients:
            return includeIngredients.joined(separator: ",")
        case .time:
           return maxReadyTime
        case .calories:
            return maxCalories
        }
    }
}
