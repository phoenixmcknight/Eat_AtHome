//
//  SpoonApiModel.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

// MARK: - RecipeWrapper
struct RecipeWrapper: Codable {
    let results: [Recipe]
    let number,totalResults: Int
}

// MARK: - Result
struct Recipe: Codable {
   
    let sourceUrl: String?
    let spoonacularSourceUrl: String?
    let sourceName: String?
    let pricePerServing: Double?
    let spoonacularScore: Double?
    let id: Int
    let title: String?
    let readyInMinutes, servings: Int?
    let image: String?
    let summary: String?
    let analyzedInstructions: [AnalyzedInstruction]?
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
struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable {
    let number: Int
    let step: String
}


