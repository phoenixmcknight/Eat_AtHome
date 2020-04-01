//
//  SearchResultViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

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
    
    private var currentQuery:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultView)
        setDelegatesToSelf()
        setUpNavigationBar()
        addTargetToButtons()
        // Do any additional setup after loading the view.
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
        SpoonAPIClient.client.getRecipes(query: currentQuery, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
                  switch result {
                  case .failure(let error):
                      print(error)
                  case .success(let recipes):
                      self?.recipeArray = recipes
                  }
              }
        
    }
    
    @objc private func sortByPrice() {
        currentSortMethod = "&sort=price"
               SpoonAPIClient.client.getRecipes(query: currentQuery, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
                         switch result {
                         case .failure(let error):
                             print(error)
                         case .success(let recipes):
                             self?.recipeArray = recipes
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
    private func changeSearchURL(query:String) {
        
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
        currentQuery = text
        SpoonAPIClient.client.getRecipes(query: text, cuisine: resultURLFilter.returnCuisines(), diet: resultURLFilter.returnDiets(), excludeIngredients: resultURLFilter.returnExcludeIngredients(), intolerances: resultURLFilter.returnExcludeIngredients(), includeIngredients: resultURLFilter.returnIncludeIngredients(), type: resultURLFilter.returnDishTypes(), maxReadyTime: resultURLFilter.returnMaxReadyTime(), maxCalories: resultURLFilter.returnMaxCalories(),sortedBy: currentSortMethod){ [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let recipes):
                self?.recipeArray = recipes
            }
        }
    }
}