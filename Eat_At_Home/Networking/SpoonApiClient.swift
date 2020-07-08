

import Foundation

class SpoonAPIClient {
    static let client = SpoonAPIClient()
    
    
    func getIngredientImageURL(ingredientName:String) -> String
    {
    return "https://spoonacular.com/cdn/ingredients_500x500/\(ingredientName)"
    }
    
        let session: URLSession
        
    
    private lazy var baseURL:URL? = {
    return URL(string: "https://api.spoonacular.com")
    }()
    
    init(session: URLSession = URLSession.shared) {
          self.session = session
    
        }
    
    func getRecipes(recipeQuery:String,offset:Int, sortMethod:sortByMethod, request:RecipeRequestParameters,completionHandler:@escaping(Result<RecipeWrapper,AppError>) -> Void) {
        guard let baseURL = baseURL?.appendingPathComponent(request.path) else {completionHandler(.failure(.badURL))
            return
        }

        var parameters:Parameters = request.parameters.merging(["offset":"\(offset)","sort":sortMethod.rawValue], uniquingKeysWith: +)
            
        if  !recipeQuery.isEmpty {
            parameters.merge(["query":recipeQuery], uniquingKeysWith: +)
        }
        
        let urlRequest = URLRequest(url: baseURL).encode(with: parameters)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                
            
            if let error = error {
                               let error = error as NSError
                               if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                                   completionHandler(.failure(.noInternetConnection))
                                   return
                               } else {
                                   completionHandler(.failure(.other(rawError: error)))
                                   return
                               }
                           }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
        guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
            completionHandler(.failure(.badStatusCode))
                    return
                        }
           
                guard let recipeData = RecipeWrapper.getRecipeWrapper(data: data) else {
                    completionHandler(.failure(.couldNotDecodeData))
                    return
                }
                completionHandler(.success(recipeData))
            }
        }.resume()
        
    }
}
