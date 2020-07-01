//
//  ExcludeIngredientViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class ExcludeIngredientViewController: UIViewController {

    let excludeIngredientView = IngredientsView()
    
     var onDoneBlock : ((Bool) -> Void)?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(excludeIngredientView)
            addDelegates()
            excludeIngredientView.changeStateOfView(include: false)
            // Do any additional setup after loading the view.
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDoneBlock!(true)
        }
        
        private func addDelegates() {
            excludeIngredientView.ingredientsTextField.delegate = self
        }
       
    }
    extension ExcludeIngredientViewController:UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard let ingredientName = textField.text else {return false}
    excludeIngredientView.createLabel(ingredientName:ingredientName , imageName: ingredientName)
            excludeIngredientView.delegate?.sendFilter(addOrRemove: .add, filterString: ingredientName, filterNumber: nil, filter: .excludeIngredients)
            return true
        }
    }
