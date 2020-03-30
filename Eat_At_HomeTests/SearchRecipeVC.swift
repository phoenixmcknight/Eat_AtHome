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
    
    var urlFilters = URLFilters()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchRecipeView)
        addDelegates()
        setUpNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    private func setUpNavigationBar()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(navigateToSearchBar))
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
    {}

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
         
           
            guard let cellOne = searchRecipeView.dishTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "dish", for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
        
        if collectionView == searchRecipeView.dishTypeCollectionView { 
        let currentItem = urlFilters.listOfDishTypes[indexPath.item].replacingOccurrences(of: ",", with: "")
               
               cellOne.foodLabel.text  = currentItem
               cellOne.foodImageView.image = UIImage(named: currentItem)
    }
        
               
      if collectionView == searchRecipeView.cuisineCollectionView {
          //
            guard let cellTwo = searchRecipeView.cuisineCollectionView.dequeueReusableCell(withReuseIdentifier: "cuisine", for: indexPath) as? SearchRecipeCourseAndCuisineCollectionViewCell else {return UICollectionViewCell()}
               
        let currentItem = urlFilters.listOfcuisines[indexPath.item].replacingOccurrences(of: ",", with: "")
        cellTwo.foodLabel.text = currentItem
        
        cellTwo.foodImageView.image = UIImage(named: currentItem)
            
           return cellTwo
        } else if collectionView == searchRecipeView.settingsCollectionView {
          //
            guard let cellThree = searchRecipeView.settingsCollectionView.dequeueReusableCell(withReuseIdentifier: "settings", for: indexPath) as? SearchRecipeSettingsCollectionViewCell else {return UICollectionViewCell()}
               
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
    
   
        
       
        
       
    }
    
   
    


extension SearchRecipeVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height * 0.15, height: view.frame.height * 0.15)
    }
    
    
}
