//
//  SearchRecipeVC.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class SearchRecipeVC: UIViewController {
    
    let searchRecipeView = SearchRecipeView()
    
    var urlFilters = URLFilters() {
        didSet {
            print(urlFilters.returnDiets())
         print(urlFilters.returnIncludeIngredients())
            print(urlFilters.returnExcludeIngredients())
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchRecipeView)
        addDelegates()
        setUpNavigationBar()
        
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
    
    @objc private func navigateToSearchBar()
    {
        navigationItem.titleView = searchRecipeView.mainSearchRecipeBar
        navigationItem.rightBarButtonItem = nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchRecipeVC:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
           
        guard let cellOne = searchRecipeView.dishTypeCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.dish.rawValue, for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
        
        if collectionView == searchRecipeView.dishTypeCollectionView {
        let currentItem = urlFilters.listOfDishTypes[indexPath.item].replacingOccurrences(of: ",", with: "")
               
               cellOne.foodLabel.text  = currentItem.replacingOccurrences(of:"+",with:" ").capitalized
            
               cellOne.foodImageView.image = UIImage(named: currentItem)
    }
        
               
      if collectionView == searchRecipeView.cuisineCollectionView {
          //
        guard let cellTwo = searchRecipeView.cuisineCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.cuisine.rawValue, for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
               
        let currentItem = urlFilters.listOfcuisines[indexPath.item].replacingOccurrences(of: ",", with: "")
        cellTwo.foodLabel.text = currentItem.replacingOccurrences(of:"+",with:" ").capitalized
        
        cellTwo.foodImageView.image = UIImage(named: currentItem)
            
           return cellTwo
        } else if collectionView == searchRecipeView.settingsCollectionView {
          //
        guard let cellThree = searchRecipeView.settingsCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.settings.rawValue, for: indexPath) as? SearchRecipeSettingsCollectionViewCell else {return UICollectionViewCell()}
               
               cellThree.foodLabel.text = urlFilters.listOfFilters[indexPath.item]
return cellThree
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
            switch selectedCell.foodLabel.text {
            case "Diet":
                let dietCV = DietCollectionViewController()
                dietCV.dietOptions = urlFilters.listOfDiets
                dietCV.delegate = self
                dietCV.dietView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.80, height: view.frame.height / 2)
                dietCV.dietView.center.x = view.center.x
                dietCV.dietView.center.y = searchRecipeView.cuisineLabel.center.y - view.frame.height * 0.025
                
                dietCV.dietView.layer.cornerRadius = 25
                dietCV.dietView.layer.masksToBounds = true
           
               dietCV.modalPresentationStyle = .formSheet
                
                dietCV.onDoneBlock = { (result) in
                        self.view.alpha = 1.0
                }
                
                view.alpha = 0.5
                present(dietCV,animated: true)
                
            case "Intolerances":
                 let intoleranceVC = IntoleranceViewController()
                               intoleranceVC.intoleranceOptions = urlFilters.listOfIntolerances
                               intoleranceVC.delegate = self
                               intoleranceVC.intoleranceView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.80, height: view.frame.height / 2)
                               intoleranceVC.intoleranceView.center.x = view.center.x
                               intoleranceVC.intoleranceView.center.y = searchRecipeView.cuisineLabel.center.y - view.frame.height * 0.025
                               
                               intoleranceVC.intoleranceView.layer.cornerRadius = 25
                               intoleranceVC.intoleranceView.layer.masksToBounds = true
                          
                              intoleranceVC.modalPresentationStyle = .formSheet
                               
                               intoleranceVC.onDoneBlock = { (result) in
                                       self.view.alpha = 1.0
                               }
                               
                 view.alpha = 0.5
                               present(intoleranceVC,animated: true)
                
            case "Include Ingredients":
                let ingredientVC = IncludeIngredientViewController()
                                             
                ingredientVC.ingredientView.delegateOne = self
                                             ingredientVC.ingredientView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.80, height: view.frame.height / 2)
                                             ingredientVC.ingredientView.center.x = view.center.x
                                             ingredientVC.ingredientView.center.y = searchRecipeView.cuisineLabel.center.y - view.frame.height * 0.025
                                             
                                             ingredientVC.ingredientView.layer.cornerRadius = 25
                                             ingredientVC.ingredientView.layer.masksToBounds = true
                                        
                                            ingredientVC.modalPresentationStyle = .formSheet
                                             
                                             ingredientVC.onDoneBlock = { (result) in
                                                     self.view.alpha = 1.0
                                             }
                                             
                                             view.alpha = 0.5
                                             present(ingredientVC,animated: true)
            case "Exclude Ingredients":
                let ingredientVC = ExcludeIngredientViewController()
                                                           
                              ingredientVC.excludeIngredientView.delegateTwo = self
                                                           ingredientVC.excludeIngredientView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.80, height: view.frame.height / 2)
                                                           ingredientVC.excludeIngredientView.center.x = view.center.x
                                                           ingredientVC.excludeIngredientView.center.y = searchRecipeView.cuisineLabel.center.y - view.frame.height * 0.025
                                                           
                                                           ingredientVC.excludeIngredientView.layer.cornerRadius = 25
                                                           ingredientVC.excludeIngredientView.layer.masksToBounds = true
                                                      
                                                          ingredientVC.modalPresentationStyle = .formSheet
                                                           
                                                           ingredientVC.onDoneBlock = { (result) in
                                                                   self.view.alpha = 1.0
                                                           }
                                                           
                                                           view.alpha = 0.5
                                                           present(ingredientVC,animated: true)
            default:
                print("")
            
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
    
    

    

