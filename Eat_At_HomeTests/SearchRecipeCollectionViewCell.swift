//
//  SearchRecipeCollectionViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class SearchRecipeCourseAndCuisineCollectionViewCell: UICollectionViewCell {
    lazy var foodImageView:UIImageView =
        {
         let image = UIImageView()
            image.contentMode = .scaleToFill
           
            image.layer.shadowColor = UIColor.black.cgColor
            image.layer.shadowRadius = 5.0
            image.layer.shadowOpacity = 10
            return image
    }()
    
    lazy var foodLabel:UILabel =
        {
            let label = UILabel()
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
            label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
            label.textColor = StyleGuide.FontStyle.fontColor
            return label
    }()
    
    
    var hasBeenSelected:Bool = false {
        didSet {
            switchBackgroundColorOfCell(bool: hasBeenSelected)
        }
    }
    
    private var currentOption:String = "empty"
    
      required init?(coder: NSCoder)
      {
          fatalError("init(coder:) has not been implemented")
      }
      
      override init(frame: CGRect)
      {
          super.init(frame: frame)
        commonInit()
      }
    
    private func commonInit()
    {
        addSubviews()
        foodImageConstraints()
        foodLabelConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    
    private func addSubviews()
    {
        self.addSubview(foodImageView)
        self.addSubview(foodLabel)
    }
    
 
    
    private func switchBackgroundColorOfCell(bool:Bool) {
           switch bool {
           case true:
               self.layer.borderWidth = 10
               self.layer.borderColor = UIColor.green.cgColor
              
           case false:
               self.layer.borderWidth = 0
               self.layer.borderColor = .none
           }
       }
    
    public func setCurrentOption(selected:String) {
        currentOption = selected
    }
    
    public func returnCurrentOption() -> String {
        return currentOption
    }
    
    private func foodImageConstraints()
    {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor),
            foodImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            foodImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
            
        ])
    }
    
    private func foodLabelConstraints()
    {
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor),
            foodLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foodLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            foodLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
