//
//  File.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 5/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

class IngredientImageAPI {
    
    static func getIngredientImageURL(ingredientName:String) -> String
      {
      return "https://spoonacular.com/cdn/ingredients_500x500/\(ingredientName)"
      }
    
}
