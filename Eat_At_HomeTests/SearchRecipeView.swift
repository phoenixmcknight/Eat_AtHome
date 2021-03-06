//
//  SearchRecipeView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class SearchRecipeView: UIView {
    
   

    lazy var mainSearchRecipeBar:UISearchBar =
        {
        let main = UISearchBar()
            main.placeholder = "Find a Recipe"
            return main
    }()
    
    lazy var customActivityIndictator = CustomIndictator(frame: .zero)

    
    lazy var dishTypeCollectionView:UICollectionView =
        {
        var layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let category = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
            category.backgroundColor = .clear
            category.register(SearchRecipeCourseAndCuisineCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.dish.rawValue)
            return category
    }()
    
    lazy var settingsCollectionView:UICollectionView =
        {
            var layout = UICollectionViewFlowLayout()
                 
                     layout.scrollDirection = .horizontal
                     let settings = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
                     settings.backgroundColor = .clear
            settings.register(SearchRecipeSettingsCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.settings.rawValue)
                     return settings
            
    }()
    
    lazy var cuisineCollectionView:UICollectionView =
           {
               var layout = UICollectionViewFlowLayout()
                        
                        layout.scrollDirection = .horizontal
                        let cuisine = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
                        cuisine.backgroundColor = .clear
           
           
            cuisine.tag = 1
            cuisine.register(SearchRecipeCourseAndCuisineCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.cuisine.rawValue)
                        return cuisine
               
       }()
    
    lazy var dishTypeLabel:UILabel =
        {
            let label = UILabel()
            label.text = "Dish Type"
            label.textAlignment = .center
                      label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 0
                      label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
                      label.textColor = StyleGuide.FontStyle.fontColor
            label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            label.layer.shadowRadius = 10
            label.layer.shadowColor = UIColor.black.cgColor
            
            return label
    }()
   
    lazy var cuisineLabel:UILabel =
           {
               let label = UILabel()
            label.text = "Cuisine"
               label.textAlignment = .center
                         label.adjustsFontSizeToFitWidth = true
                         label.numberOfLines = 0
                         label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
                         label.textColor = StyleGuide.FontStyle.fontColor
            label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                      label.layer.shadowRadius = 10
                      label.layer.shadowColor = UIColor.black.cgColor
               return label
       }()
    
    lazy var settingsLabel:UILabel =
           {
            
               let label = UILabel()
            label.text = "Filters"
               label.textAlignment = .center
                         label.adjustsFontSizeToFitWidth = true
                         label.numberOfLines = 0
                         label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
                         label.textColor = StyleGuide.FontStyle.fontColor
            
            label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                      label.layer.shadowRadius = 10
                      label.layer.shadowColor = UIColor.black.cgColor
               return label
       }()
    
    lazy var searchButton:UIButton =
        {
    let button = UIButton()
        button.setTitle("Search", for: .normal)
            button.setTitleColor(StyleGuide.AppColors.backgroundColor, for: .normal)
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 3
            
return button
    }()
    
    

    
    override init(frame:CGRect)
    {
        super.init(frame:UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    private func commonInit()
    {
        addSubviews()
        dishTypeLabelConstraints()
        dishTypeCollectionViewConstraints()
        cuisineLabelConstraints()
        cuisineCollectionViewConstraints()
        filterLabelConstraints()
        settingsCollectionViewConstraints()
        buttonConstraints()
        self.setGradientBackground(colorTop: StyleGuide.AppColors.backgroundColor, colorBottom: #colorLiteral(red: 0.4716594219, green: 0.01316980645, blue: 0, alpha: 1))
        customActivityIndictator.setToCenter(view: self, sizeRelativeToView: 0.3)
    }
    
    private func addSubviews()
    {
        self.addSubview(dishTypeLabel)
        self.addSubview(dishTypeCollectionView)
        self.addSubview(cuisineLabel)
        self.addSubview(cuisineCollectionView)
        self.addSubview(settingsLabel)
        self.addSubview(settingsCollectionView)
        self.addSubview(searchButton)
        self.addSubview(customActivityIndictator)
    }
    
   
    private func dishTypeLabelConstraints()
    {
        dishTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dishTypeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: self.frame.height * 0.025),
            dishTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dishTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dishTypeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
    
    private func dishTypeCollectionViewConstraints()
    {
        dishTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishTypeCollectionView.topAnchor.constraint(equalTo: dishTypeLabel.bottomAnchor),
            dishTypeCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dishTypeCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dishTypeCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
    
    
    private func cuisineLabelConstraints()
    {
        cuisineLabel.translatesAutoresizingMaskIntoConstraints = false
              
              NSLayoutConstraint.activate([
                cuisineLabel.topAnchor.constraint(equalTo: dishTypeCollectionView.bottomAnchor),
                  cuisineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                  cuisineLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                  cuisineLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
              ])
    }
    
   
    
   private func cuisineCollectionViewConstraints()
   {
    cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        cuisineCollectionView.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor),
               cuisineCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               cuisineCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               cuisineCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
           ])
    }
    
    private func filterLabelConstraints() {
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        settingsLabel.topAnchor.constraint(equalTo: cuisineCollectionView.bottomAnchor),
                       settingsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                       settingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                       settingsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.025)
        ])
    }
   
    private func settingsCollectionViewConstraints()
    {
        settingsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        settingsCollectionView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor),
        settingsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        settingsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        settingsCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func buttonConstraints()
    {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: settingsCollectionView.bottomAnchor),
            searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
          //  buttonNameTBD.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.075)
            searchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -UIScreen.main.bounds.height * 0.01)
            
        ])
    }
    
}
