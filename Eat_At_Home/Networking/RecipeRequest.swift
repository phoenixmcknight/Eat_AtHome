

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
  
    static let defaultRequestNumber:Int = 25
  
    let parameters: Parameters
     private init(parameters: Parameters) {
       self.parameters = parameters
     }
    
}

extension RecipeRequestParameters {
   
    static func from(urlFilters:URLFilters) -> RecipeRequestParameters {
       let defaultParameters = ["apiKey": "\(Secrets.spoonApiKey)","addRecipeInformation":"true","instructionsRequired":"true","number":"\(defaultRequestNumber)"]
           
       
        var parameters:Parameters = defaultParameters
        
        parameters.merge(urlFilters.returnParameter(), uniquingKeysWith: +)
        
           
       return RecipeRequestParameters(parameters: parameters)
     }
    
}

