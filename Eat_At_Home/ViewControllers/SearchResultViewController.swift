import UIKit

class SearchResultViewController: UIViewController {

    let searchResultView = SearchResultView()
    
    var resultURLFilter:URLFilters!
    
    var recipeArray:[Recipe] = [] {
        didSet {
            searchResultView.resultCollectionView.reloadData()
        }
    }
    private var currentSortMethod:String = "&sort=newest"
    
     var currentQuery:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultView)
        setDelegatesToSelf()
        setUpNavigationBar()
        addTargetToButtons()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = currentQuery
    }
    
    private func setDelegatesToSelf() {
        searchResultView.resultCollectionView.delegate = self
        searchResultView.resultCollectionView.dataSource = self
    }
    
    private func addTargetToButtons() {
        searchResultView.buttonOne.addTarget(self, action: #selector(sortByNewest), for: .touchUpInside)
        searchResultView.buttonTwo.addTarget(self, action: #selector(sortByPrice), for: .touchUpInside)
    }
    
    
    @objc private func navigateToSearchBar()
       {
           navigationItem.titleView = searchResultView.mainSearchRecipeBar
           navigationItem.rightBarButtonItem = nil
       }
    
    @objc private func sortByNewest() {
      currentSortMethod = "&sort=newest"
        searchResultView.customActivityIndictator.startAnimating()
        SpoonAPIClient.client.getRecipes(query: currentQuery, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
                  switch result {
                  case .failure(let error):
                    self?.searchResultView.customActivityIndictator.stopAnimating()
                      print(error)
                  case .success(let recipes):
                      self?.recipeArray = recipes
                      self?.searchResultView.customActivityIndictator.stopAnimating()
                  }
              }
        
    }
    
    @objc private func sortByPrice() {
        searchResultView.customActivityIndictator.startAnimating()
        currentSortMethod = "&sort=price"
               SpoonAPIClient.client.getRecipes(query: currentQuery, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
                         switch result {
                         case .failure(let error):
                             print(error)
                             self?.searchResultView.customActivityIndictator.stopAnimating()
                         case .success(let recipes):
                             self?.recipeArray = recipes
                             self?.searchResultView.customActivityIndictator.stopAnimating()
                         }
                     }
    }
    
    private func setUpNavigationBar()
       {
           let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(navigateToSearchBar))
           
           
           navigationItem.rightBarButtonItem = barButton
          //change this
           navigationItem.title = "Recipes"
           
           
       }
    
    
}
extension SearchResultViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.result.rawValue, for: indexPath) as? SearchResultCollectionViewCell else
        {return UICollectionViewCell()}
        
      
        
        let currentRecipe = recipeArray[indexPath.item]
        
        let summary =  currentRecipe.summary?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "/a>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
        
        cell.descriptionLabel.text = summary
        
        cell.starRatingImageView.image = RatingsModel.shared.returnCorrectStarImage(score: currentRecipe.spoonacularScore ?? 0)
        
       
            cell.ratingsLabel.text = "\(currentRecipe.spoonacularScore ?? 0)"
        
        
        cell.recipeTitleLabel.text = currentRecipe.title
        
        if let servings = currentRecipe.servings {
             cell.servingsLabel.text = "Servings: \(servings)"
        } else {
            cell.servingsLabel.text = "Servings: Unavailable"
        }
        cell.viewRecipeButton.tag = indexPath.item
        cell.delegate = self
        cell.imageActivityIndc.startAnimating()
        
        if let image = currentRecipe.image {
        
        ImageHelper.shared.getImage(urlStr: image  ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    cell.imageActivityIndc.stopAnimating()
                case .success(let image):
                    cell.foodImageView.image = image
                    cell.imageActivityIndc.stopAnimating()
                }
            }
        }
        }
        return cell
        
    }
    
}

extension SearchResultViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height * 0.35, height: view.frame.height * 0.35)
       }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
      
}

extension SearchResultViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        searchResultView.customActivityIndictator.startAnimating()
        currentQuery = text
        SpoonAPIClient.client.getRecipes(query: text, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                self?.searchResultView.customActivityIndictator.stopAnimating()
            case .success(let recipes):
                self?.recipeArray = recipes
                self?.searchResultView.customActivityIndictator.stopAnimating()

            }
        }
    }
}
extension SearchResultViewController:SearchResultCellDelegate {
    func navigateToDetailVC(tag: Int) {
          let detailVC = DetailRecipeViewController()
        
        searchResultView.customActivityIndictator.startAnimating()
        guard let selectedCell = searchResultView.resultCollectionView.cellForItem(at: IndexPath(item: tag, section: 0)) as? SearchResultCollectionViewCell else {return}
              detailVC.recipeImage = selectedCell.foodImageView.image ?? UIImage(named:"Italian")!
              detailVC.recipe = recipeArray[tag]
        searchResultView.customActivityIndictator.stopAnimating()
              navigationController?.pushViewController(detailVC, animated: true)
    }
    
  
    
}
