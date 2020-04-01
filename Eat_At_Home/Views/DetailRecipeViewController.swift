//
//  DetailRecipeViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {

    let detailRecipeView = DetailRecipeView()
    var recipeImage:UIImage = UIImage()
    var recipe:Recipe!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailRecipeView)
        setUpView()
        addTargetToStepper()

    }
    
    private func addTargetToStepper() {
        detailRecipeView.cartStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
   @objc func stepperValueChanged(_ sender:UIStepper!)
       {
           print("UIStepper is now \(Int(sender.value))")
       }

    
    @objc private func stepperFunction(sender:UIStepper) {
        print(sender.value)
        detailRecipeView.cartLabel.text = "Items In Cart: \(sender.value)"
    }

    private func setUpView() {
        detailRecipeView.foodImageView.image = recipeImage
        detailRecipeView.descriptionTextView.text = recipe.summary
        detailRecipeView.recipeTitleLabel.text = recipe.title
    }

}



