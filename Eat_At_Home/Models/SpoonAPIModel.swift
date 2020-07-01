//
//  SpoonAPIModel.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation


// MARK: - RecipeWrapper
struct RecipeWrapper: Codable {
    let results: [Recipe]
    let number,totalResults: Int
    
    static func getRecipeWrapper(data:Data) -> RecipeWrapper? {
        do {
            let recipeWrapperData = try JSONDecoder().decode(RecipeWrapper.self, from: data)
            return recipeWrapperData
        } catch {
            return nil
        }
    }
}

// MARK: - Result
struct Recipe: Codable,Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
      return  lhs.id == rhs.id
    }
    
   
    let sourceUrl: String?
    let spoonacularSourceUrl: String?
    let sourceName: String?
    let pricePerServing: Double?
    let spoonacularScore: Double?
    let id: Int
    let title: String?
    let readyInMinutes, servings: Int?
    let image: String?
    var summary: String?
    var formattedSummary:String {
    
        return summary?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "/a>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
    }
  //  let analyzedInstructions: [AnalyzedInstruction]?
    let preparationMinutes, cookingMinutes: Int?
    
    static func getRecipeData(data:Data)throws -> [Recipe]? {
             do{
                 let recipeData = try
                     JSONDecoder().decode(RecipeWrapper.self, from: data)
                return recipeData.results
             } catch {
                 print(error)
                 return nil
             }
         }

}

// MARK: - AnalyzedInstruction
//struct AnalyzedInstruction: Codable {
//    let name: String
//    let steps: [Step]
//}

// MARK: - Step
//struct Step: Codable {
//    let number: Int
//    let step: String
//}
