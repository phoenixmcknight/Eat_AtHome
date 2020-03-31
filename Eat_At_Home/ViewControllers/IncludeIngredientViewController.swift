//
//  IngredientViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class IncludeIngredientViewController: UIViewController {

    let ingredientView = IngredientsView()
    
      var onDoneBlock : ((Bool) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ingredientView)
        addDelegates()
        ingredientView.changeStateOfView(include: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onDoneBlock!(true)
    }
    
    private func addDelegates() {
        ingredientView.ingredientsTextField.delegate = self
    }
   
}
extension IncludeIngredientViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let ingredientName = textField.text else {return false}
        
ingredientView.createLabel(ingredientName:ingredientName , imageName: ingredientName)
        
ingredientView.delegateOne?.sendIngredient(isAdding: true, ingredient: ingredientName)
        return true
    }
}
