import UIKit

class SearchRecipeVC: UIViewController {
    
    let searchRecipeView = SearchRecipeView()
    
    var urlFilters = URLFilters() {
        didSet {
          //  print(urlFilters.returnDiets())
            print(urlFilters.returnCuisines())
            print(urlFilters.returnDishTypes())
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchRecipeView)
        addDelegates()
        setUpNavigationBar()
        addTargetToViewButtons()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    private func setUpNavigationBar()
    {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(navigateToSearchBar))
        
        
        navigationItem.rightBarButtonItem = barButton
        
        navigationItem.title = "Search For Recipes"
        
        
    }
    
    private func addDelegates() {
        searchRecipeView.dishTypeCollectionView.delegate = self
        searchRecipeView.cuisineCollectionView.delegate = self
        searchRecipeView.settingsCollectionView.delegate = self
        
        searchRecipeView.dishTypeCollectionView.dataSource = self
        searchRecipeView.cuisineCollectionView.dataSource = self
        
        searchRecipeView.settingsCollectionView.dataSource = self
    }
    
    private func addTargetToViewButtons() {
        searchRecipeView.buttonNameTBD.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc private func navigateToSearchBar()
    {
        
        navigationItem.titleView = searchRecipeView.mainSearchRecipeBar
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func search() {
       let searchResultVC = SearchResultViewController()
    
        
        SpoonAPIClient.client.getRecipes(query: searchRecipeView.mainSearchRecipeBar.text ?? "", cuisine: urlFilters.returnCuisines(), diet: urlFilters.returnDiets(), excludeIngredients: urlFilters.returnExcludeIngredients(), intolerances: urlFilters.returnExcludeIngredients(), includeIngredients: urlFilters.returnIncludeIngredients(), type: urlFilters.returnDishTypes(), maxReadyTime: urlFilters.returnMaxReadyTime(), maxCalories: urlFilters.returnMaxCalories(),sortedBy: "&sort=newest") { [weak self] (result) in
            switch result {
            case .failure( _):
                self?.showAlert(title: "Error", message: "Could Not Load Events")
            case .success(let recipes):
                searchResultVC.recipeArray = recipes
                searchResultVC.resultURLFilter = self?.urlFilters
                self?.navigationController?.pushViewController(searchResultVC, animated: true)
            
            }
        }
        
    }
    private func configureVCForPresentation(subView:UIView,viewController:UIViewController) {
        subView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.80, height: view.frame.height / 2)
        subView.center.x = view.center.x
        subView.center.y = searchRecipeView.cuisineLabel.center.y - view.frame.height * 0.025
        
        subView.layer.cornerRadius = 25
        subView.layer.masksToBounds = true
        
        viewController.modalPresentationStyle = .formSheet
    }
    
}

extension SearchRecipeVC:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cellOne = searchRecipeView.dishTypeCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.dish.rawValue, for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
        
        if collectionView == searchRecipeView.dishTypeCollectionView {
            let currentItem = urlFilters.listOfDishTypes[indexPath.item].replacingOccurrences(of: ",", with: "")
            
            cellOne.foodLabel.text  = currentItem.replacingOccurrences(of:"+",with:" ").capitalized
            
            cellOne.foodImageView.image = UIImage(named: currentItem)
            print("\(indexPath.item)",cellOne.returnCurrentOption())
            if urlFilters.returnDishTypes().contains(cellOne.returnCurrentOption()) {
                cellOne.hasBeenSelected = true
            } else {
                cellOne.hasBeenSelected = false
            }
        } else {
        if collectionView == searchRecipeView.cuisineCollectionView {
            
            guard let cellTwo = searchRecipeView.cuisineCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.cuisine.rawValue, for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
            
            let currentItem = urlFilters.listOfcuisines[indexPath.item].replacingOccurrences(of: ",", with: "")
            cellTwo.foodLabel.text = currentItem.replacingOccurrences(of:"+",with:" ").capitalized
            
            cellTwo.foodImageView.image = UIImage(named: currentItem)
            
            if urlFilters.returnDishTypes().contains(cellTwo.returnCurrentOption()) {
                cellTwo.hasBeenSelected = true
            } else {
                cellTwo.hasBeenSelected = false
            }
            
            return cellTwo
        }
        
        if collectionView == searchRecipeView.settingsCollectionView {
            //
            guard let cellThree = searchRecipeView.settingsCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.settings.rawValue, for: indexPath) as? SearchRecipeSettingsCollectionViewCell else {return UICollectionViewCell()}
            
            cellThree.foodLabel.text = urlFilters.listOfFilters[indexPath.item]
            
            if urlFilters.returnDishTypes().contains(cellThree.returnCurrentOption()) {
                cellThree.hasBeenSelected = true
                    
            } else {
                cellThree.hasBeenSelected = false
            }
            return cellThree
        }
        }
        return cellOne
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = urlFilters.listOfDishTypes.count
        if collectionView == searchRecipeView.cuisineCollectionView {
            
            return urlFilters.listOfcuisines.count
        } else if collectionView == searchRecipeView.settingsCollectionView {
            return urlFilters.listOfFilters.count
        }
        return count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == searchRecipeView.settingsCollectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath) as? SearchRecipeSettingsCollectionViewCell else {return}
            
            let currentSetting:String = urlFilters.listOfFilters[indexPath.item]
            
            selectedCell.setCurrentOption(selected: currentSetting)
            switch selectedCell.foodLabel.text {
            case "Diet":
                let dietCV = DietCollectionViewController()
                dietCV.dietOptions = urlFilters.listOfDiets
                dietCV.delegate = self
                
                configureVCForPresentation(subView: dietCV.dietView, viewController: dietCV)
                
                dietCV.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(dietCV,animated: true)
                
            case "Intolerances":
                let intoleranceVC = IntoleranceViewController()
                intoleranceVC.intoleranceOptions = urlFilters.listOfIntolerances
                intoleranceVC.delegate = self
                
                configureVCForPresentation(subView: intoleranceVC.intoleranceView, viewController: intoleranceVC)
                
                intoleranceVC.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(intoleranceVC,animated: true)
                
            case "Include Ingredients":
                let ingredientVC = IncludeIngredientViewController()
                
                ingredientVC.ingredientView.delegateOne = self
                
                configureVCForPresentation(subView: ingredientVC.ingredientView, viewController: ingredientVC)
                
                ingredientVC.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(ingredientVC,animated: true)
            case "Exclude Ingredients":
                let ingredientVC = ExcludeIngredientViewController()
                
                ingredientVC.excludeIngredientView.delegateTwo = self
                
                configureVCForPresentation(subView: ingredientVC.excludeIngredientView, viewController: ingredientVC)
                
                ingredientVC.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(ingredientVC,animated: true)
                
            case "Ready Time":
                let  readyTimeVC = ReadyTimeViewController()
                
                readyTimeVC.delegate = self
                
                configureVCForPresentation(subView: readyTimeVC.readyTimeView, viewController: readyTimeVC)
                readyTimeVC.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(readyTimeVC,animated: true)
                
            case "Max Calories":
                let caloriesVC = CaloriesViewController()
                caloriesVC.delegate = self
                configureVCForPresentation(subView: caloriesVC.caloriesView, viewController: caloriesVC)
                caloriesVC.onDoneBlock = { (result) in
                    self.view.alpha = 1.0
                }
                view.alpha = 0.5
                present(caloriesVC,animated: true)
            default:
                print("")
                
            }
            
        } else if collectionView == searchRecipeView.cuisineCollectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return}
            
            let currentCuisine = urlFilters.listOfcuisines[indexPath.item]
            
            print("this is the tag",collectionView.tag)
            
            if selectedCell.hasBeenSelected == true {
                selectedCell.setCurrentOption(selected: "")
                urlFilters.removeCuisine(cuisine: currentCuisine)
                selectedCell.hasBeenSelected = false
            } else {
                selectedCell.setCurrentOption(selected: currentCuisine)
                urlFilters.addCuisine(newCuisine: currentCuisine)
                selectedCell.hasBeenSelected = true
            }
          
            
        } else if collectionView == searchRecipeView.dishTypeCollectionView {
            
             guard let selectedCell = collectionView.cellForItem(at: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return}
            
            let currentDishType = urlFilters.listOfDishTypes[indexPath.item]
            
            
            if selectedCell.hasBeenSelected == true {
                urlFilters.removeDishType(dishType: currentDishType)
                selectedCell.setCurrentOption(selected: "empty")
                selectedCell.hasBeenSelected = false
            } else {
                
                urlFilters.addDishType(newType: currentDishType)
                selectedCell.setCurrentOption(selected: currentDishType)
                selectedCell.hasBeenSelected = true
            }
            
        }
    }
    
}





extension SearchRecipeVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height * 0.15, height: view.frame.height * 0.15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
}

extension SearchRecipeVC:UISearchBarDelegate {}

extension SearchRecipeVC:DietCollectionViewDelegate {
    func sendDietSelection(diet: String, isAdding: Bool) {
        switch isAdding {
        case true:
            urlFilters.addDiet(newDiet: diet)
        case false:
            urlFilters.removeDiet(diet: diet)
        }
    }
}
extension SearchRecipeVC:IntoleranceViewControllerDelegate {
    func sendIntoleranceSelection(intolerance: String, isAdding: Bool) {
        switch isAdding {
        case true:
            urlFilters.addIntolerance(newIntolerance: intolerance)
        case false:
            urlFilters.removeIntolerance(intolerance: intolerance)
        }
    }
}
extension SearchRecipeVC:IncludeIngredientDelegate {
    func sendIngredient(isAdding: Bool, ingredient: String) {
        switch isAdding {
        case true:
            urlFilters.includeIngredient(ingredient: ingredient)
        case false:
            urlFilters.removeIngredient(ingredient: ingredient)
        }
        
    }
}

extension SearchRecipeVC:ExcludeIngredientDelegate {
    func exlcudeIngredient(isAdding: Bool, ingredient: String) {
        switch isAdding {
        case true:
            urlFilters.excludeIngredient(ingredient: ingredient)
        case false:
            urlFilters.removeExcludedIngredient(ingredient: ingredient)
        }
        
    }
    
}

extension SearchRecipeVC:ReadyTimeDelegate {
    func sendTime(time: Int) {
        urlFilters.changeMaxReadyTime(newMaxReadyTime: time)
    }
}
extension SearchRecipeVC:CaloriesDelegate {
    func sendCalories(calories: Int) {
        urlFilters.changeMaxCalories(newMaxCalories: calories)
    }
    
    
}
