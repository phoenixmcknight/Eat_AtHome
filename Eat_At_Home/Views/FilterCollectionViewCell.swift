//
//  DietCollectionViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/29/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterIsSelected:Bool = false {
           didSet {
               switchBackgroundColorOfCell(bool: filterIsSelected)
           }
       }
    
    var currentOption:String = ""
   
    lazy var dietImageView:UIImageView =
          {
           let image = UIImageView()
              image.contentMode = .scaleToFill
             
              image.layer.shadowColor = UIColor.black.cgColor
              image.layer.shadowRadius = 5.0
              image.layer.shadowOpacity = 10
              return image
      }()
      
      lazy var dietFoodLabel:UILabel =
          {
              let label = UILabel()
              label.textAlignment = .center
              label.adjustsFontSizeToFitWidth = true
              label.numberOfLines = 0
              label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
              label.textColor = StyleGuide.FontStyle.fontColor
              return label
      }()
    
    lazy var intoleranceActivityIndc:UIActivityIndicatorView =
        {
      let activity = UIActivityIndicatorView()
            activity.hidesWhenStopped = true
            activity.contentMode = .center
            activity.style = .medium
            return activity
        }()
   
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        dietImageViewConstraints()
        dietLabelConstraints()
        activityIndicatorConstraints()
    }
    
    
    private func addSubviews() {
        self.addSubview(dietImageView)
        self.addSubview(dietFoodLabel)
        self.addSubview(intoleranceActivityIndc)
    }
    
    private func dietLabelConstraints()
    {
        dietFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dietFoodLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dietFoodLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
         dietFoodLabel.leadingAnchor.constraint(equalTo: dietImageView.trailingAnchor),
         dietFoodLabel.heightAnchor.constraint(equalTo: dietImageView.heightAnchor)
        ])
    }
    
    private func dietImageViewConstraints()
    {
        dietImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        dietImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        dietImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        dietImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
        dietImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.3)
        ])
        
    }
    private func activityIndicatorConstraints() {
        intoleranceActivityIndc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            intoleranceActivityIndc.centerXAnchor.constraint(equalTo: dietImageView.centerXAnchor),
            intoleranceActivityIndc.centerYAnchor.constraint(equalTo: self.dietImageView.centerYAnchor)
        ])
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
}
