

import Foundation
import UIKit

 protocol RecipeViewModelDelegate: AnyObject {
 func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}



 class RecipeViewModel {
   weak var delegate: RecipeViewModelDelegate?
  
  private var searchRecipes: [Recipe] = []
  private var offSet = 0
  private var total = 0
  private var isFetchInProgress = false
  private var sortMethod:sortByMethod = .popularity
  private var searchQuery:String
  
  let request: RecipeRequestParameters
    

  
    init(request: RecipeRequestParameters, searchQuery:String) {
    self.request = request
    self.searchQuery = searchQuery
  }
  
  var totalCount: Int {

    return total
  }
  
  var currentCount: Int {
    return searchRecipes.count
  }
  
  func recipe(at index: Int) -> Recipe {

    return searchRecipes[index]
  }
    
    func changeSortMethod(tag:Int) {
   
    sortMethod = sortByTag(tag: tag)
    offSet = 0
    searchRecipes = []
    }
    
   
    func changeQuery(newQuery:String) {
        searchQuery = newQuery
    }
    
    
    func fetchRecipes() {
        guard !isFetchInProgress else {return}
        
        isFetchInProgress = true
        
        SpoonAPIClient.client.getRecipes(recipeQuery: searchQuery, offset: offSet, sortMethod: sortMethod, request: request) { [weak self] (result) in
            switch result {
            case .failure(let error):
                    self?.isFetchInProgress = false
                    self?.delegate?.onFetchFailed(with: error.localizedDescription)
            
            case .success(let apiResponse):
                self?.isFetchInProgress = false
                self?.offSet += RecipeRequestParameters.defaultRequestNumber
                self?.total = apiResponse.totalResults
                self?.searchRecipes.append(contentsOf: apiResponse.results)
                if self!.offSet > 0 {
                    let indexPathsToReload = self?.calculateIndexPathsToReload(from: apiResponse.results)
                    self?.delegate?.onFetchCompleted(with: indexPathsToReload)
                            } else {
                    self?.delegate?.onFetchCompleted(with: .none)
                }
        }
    }
    }
    
  
  private func calculateIndexPathsToReload(from newRecipes: [Recipe]) -> [IndexPath] {
    let startIndex = searchRecipes.count - newRecipes.count
    let endIndex = startIndex + newRecipes.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }
    private func sortByTag(tag:Int) -> sortByMethod {
           switch tag {
           case 0:
              return .time
           case 1:
             return .price
           default:
               return .popularity
           }
       }
    
}

