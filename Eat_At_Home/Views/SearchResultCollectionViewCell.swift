//
//  SearchResultCollectionViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

protocol SearchResultCellDelegate:AnyObject {
    func navigateToDetailVC(tag:Int)
}

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    weak var delegate:SearchResultCellDelegate?
    
   lazy var foodImageView:UIImageView =
          {
           let image = UIImageView()
              image.contentMode = .scaleToFill
             
              image.layer.shadowColor = UIColor.black.cgColor
              image.layer.shadowRadius = 5.0
              image.layer.shadowOpacity = 10
              return image
      }()
    
    lazy var starRatingImageView:UIImageView =
        {
            let image = UIImageView()
            image.contentMode = .scaleToFill
            image.image = UIImage(named: "stars_0")
                        return image
    }()
    
    lazy var recipeTitleLabel:UILabel = {
        let label = UILabel(text: "Food Title Label",fontsize:12)
        return label
    }()
    
    lazy var ratingsLabel:UILabel = {
        let label = UILabel(text: "Ratings Label",fontsize:12)
        return label
    }()
    
    lazy var servingsLabel:UILabel = {
        let label  = UILabel(text: "Submitted By",fontsize:12)
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel(text: "Greens and Beans might be just the side dish you are searching for. This recipe makes 4 servings with <b>61 calories</b>, <b>3g of protein</b>, and <b>2g of fat</b> each. For <b>$1.34 per serving</b>, this recipe <b>covers 17%</b> of your daily requirements of vitamins and minerals. It is a good option if you're following a <b>gluten free and vegan</b> diet. A couple people made this recipe, and 30 would say it hit the spot. Head to the store and pick up garlic, beans, cherry tomatoes, and a few other things to make it today. From preparation to the plate, this recipe takes roughly <b>45 minutes</b>. All things considered, we decided this recipe <b>deserves a spoonacular score of 98%</b>. This score is amazing. Try <a href=\"https://spoonacular.com/recipes/beans-and-greens-96608\">Beans and Greens</a>, <a href=\"https://spoonacular.com/recipes/beans-and-greens-418240\">Beans and Greens</a>, and <a href=\"https://spoonacular.com/recipes/bbq-beans-greens-607930\">BBQ Beans & Greens</a> for similar recipes.",fontsize:12)
        
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    lazy var viewRecipeButton:UIButton = {
    let button = UIButton()
        button.setTitle("Click To See More", for: .normal)
             button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
             button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size:  22)
             button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
             button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
             button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var imageActivityIndc:UIActivityIndicatorView = {
           let act = UIActivityIndicatorView()
           act.hidesWhenStopped = true
           act.style = .large
           act.startAnimating()
           return act
       }()
    
    private var distanceFromEdge:CGFloat = 0
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func commonInit() {
        addSubviews()
        distanceFromEdge = self.frame.height * 0.05
        foodImageConstraint()
        activityIndcConstraints()
        recipeLabelConstraints()
        ratingImageViewConstraints()
        ratingsLabelConstraints()
        submittedByLabelConstraints()
        descriptionLabelConstraints()
        recipeButtonConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    
    private func addSubviews() {
        self.addSubview(foodImageView)
        foodImageView.addSubview(imageActivityIndc)
        self.addSubview(recipeTitleLabel)
        self.addSubview(starRatingImageView)
        self.addSubview(ratingsLabel)
        self.addSubview(servingsLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(viewRecipeButton)
    }
    
    private func foodImageConstraint() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: distanceFromEdge),
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: distanceFromEdge),
            foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.4),
            foodImageView.widthAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.4)
        ])
    }
    
    @objc private func buttonTapped(sender:UIButton) {
        delegate?.navigateToDetailVC(tag: sender.tag)
    }
    
    private func recipeLabelConstraints() {
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: distanceFromEdge),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
            recipeTitleLabel.heightAnchor.constraint(equalTo: foodImageView.heightAnchor, multiplier: 0.3),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -distanceFromEdge)
        ])
    }
    
    private func ratingImageViewConstraints() {
        starRatingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starRatingImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
//            starRatingImageView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor,constant: self.frame.width * 0.05),
           
            starRatingImageView.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            starRatingImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            
            starRatingImageView.widthAnchor.constraint(equalTo: recipeTitleLabel.widthAnchor, multiplier: 0.5)
        ])
    }
    private func ratingsLabelConstraints() {
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingsLabel.topAnchor.constraint(equalTo: starRatingImageView.bottomAnchor),
            ratingsLabel.centerXAnchor.constraint(equalTo: starRatingImageView.centerXAnchor),
            ratingsLabel.heightAnchor.constraint(equalTo: starRatingImageView.heightAnchor,multiplier: 1.5),
            ratingsLabel.widthAnchor.constraint(equalTo: starRatingImageView.widthAnchor)
        ])
    }
    
    private func submittedByLabelConstraints() {
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            servingsLabel.topAnchor.constraint(equalTo: ratingsLabel.bottomAnchor),
          //  submittedByLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
         //   submittedByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: distanceFromEdge),
            servingsLabel.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            servingsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            servingsLabel.heightAnchor.constraint(equalTo: ratingsLabel.heightAnchor)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor,constant: distanceFromEdge),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: distanceFromEdge),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -distanceFromEdge),
            descriptionLabel.heightAnchor.constraint(equalTo: foodImageView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func recipeButtonConstraints() {
        viewRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewRecipeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            viewRecipeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewRecipeButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.6),
            //viewRecipeButton.heightAnchor.constraint(equalTo: titleUILabel.heightAnchor, constant: 0.8)
            viewRecipeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -distanceFromEdge)
        ])
    }
    
    private func activityIndcConstraints() {
           imageActivityIndc.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([

            imageActivityIndc.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
            imageActivityIndc.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
           ])
       }
    
}
