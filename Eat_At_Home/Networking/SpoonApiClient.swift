

import Foundation

class SpoonAPIClient {
    static let client = SpoonAPIClient()
    
    func getIngredientImageURL(ingredientName:String) -> String
    {
    return "https://spoonacular.com/cdn/ingredients_500x500/\(ingredientName)"
    }
    
    func getRecipes(query keyWord:String,cuisine:String,diet:String,excludeIngredients:String,intolerances:String,includeIngredients:String,type course:String,maxReadyTime:String,maxCalories:String,sortedBy:String, completionHandler:@escaping(Result<[Recipe],AppError>)-> Void)
    {
    
        //change &number when you finish testing
        let urlStr = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Secrets.spoonApiKey)&addRecipeInformation=true&instructionsRequired=true&author&number=2\(keyWord.replacingOccurrences(of: " ", with: "+"))\(cuisine)\(diet)\(excludeIngredients)\(includeIngredients)\(intolerances)\(course)\(maxReadyTime)\(maxCalories)\(sortedBy)"
        

        
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
