//
//  SpoonApiClient.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

class SpoonAPIClient {
    static let client = SpoonAPIClient()
    
    func getRecipes(query keyWord:String,cuisine:String,diet:String,excludeIngredients:String,intolerances:String,includeIngredients:String,type course:String,maxReadyTime:Int,maxCalories:Int, completionHandler:@escaping(Result<[Recipe],AppError>)-> Void) {
    
        //change &number when you finish testing
        let urlStr = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Secrets.spoonApiKey)&instructionsRequired=true&author&number=10\(keyWord)\(cuisine)\(diet)\(excludeIngredients)\(includeIngredients)\(intolerances)\(course)\(maxReadyTime)\(maxCalories)"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case.success(let recipeData):
                do {
                    let recipeArray = try Recipe.getRecipeData(data: recipeData)
                    completionHandler(.success(recipeArray ?? []))
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
