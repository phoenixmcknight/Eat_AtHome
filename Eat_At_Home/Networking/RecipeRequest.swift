

import Foundation

enum Methods:String {
          case GET
          case POST
      }

enum sortByMethod:String {
   case meta_score
   case popularity
   case healthiness
   case price
   case time
   case random
}

struct RecipeRequestParameters {
  var path: String {
    return "recipes/complexSearch"
  }
    
    var method:Methods = .GET
  
  
    let parameters: Parameters
     private init(parameters: Parameters) {
       self.parameters = parameters
     }
    
}

extension RecipeRequestParameters {
   
    static func from(urlFilters:URLFilters) -> RecipeRequestParameters {
       let defaultParameters = ["apiKey": "\(Secrets.spoonApiKey)","addRecipeInformation":"true","instructionsRequired":"true","number":"10"]
           
       
        var parameters:Parameters = defaultParameters
        
        if !urlFilters.returnFilter(filter: .dishType)!.isEmpty  {
            parameters.merge(["type" : urlFilters.returnFilter(filter: .dishType)!], uniquingKeysWith: +)
        }
        
        if !urlFilters.returnFilter(filter: .cuisine)!.isEmpty  {
                     parameters.merge(["cuisine" : urlFilters.returnFilter(filter: .cuisine)!], uniquingKeysWith: +)
               }
        
        if !urlFilters.returnFilter(filter: .diet)!.isEmpty  {
                     parameters.merge(["diet" : urlFilters.returnFilter(filter: .diet)!], uniquingKeysWith: +)
               }
        
        if !urlFilters.returnFilter(filter: .excludeIngredients)!.isEmpty  {
                     parameters.merge(["excludeIngredients" : urlFilters.returnFilter(filter: .excludeIngredients)!], uniquingKeysWith: +)
               }
        
        if !urlFilters.returnFilter(filter: .includeIngredients)!.isEmpty  {
                     parameters.merge(["includeIngredients" : urlFilters.returnFilter(filter: .includeIngredients)!], uniquingKeysWith: +)
               }
        
        if !urlFilters.returnFilter(filter: .intolerance)!.isEmpty  {
                     parameters.merge(["intolerances" : urlFilters.returnFilter(filter: .intolerance)!], uniquingKeysWith: +)
               }
           
        if let maxTime = urlFilters.returnFilter(filter: .time) {
               parameters.merge( ["maxReadyTime":"\(maxTime)"], uniquingKeysWith: +)
           }
        if let maxCal = urlFilters.returnFilter(filter: .calories) {
               parameters.merge(["maxCalories":"\(maxCal)"], uniquingKeysWith: +)
           }
        
           
       return RecipeRequestParameters(parameters: parameters)
     }
    
}

