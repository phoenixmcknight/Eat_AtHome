//
//  CartViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    let cartView = CartView()
    let emptyCart = EmptyCartView()
    let cellSpacingHeight: CGFloat = 10
    var filteredRecipeArray:[Recipe] = [] 
    var actualRecipeArray:[Recipe] = [] {
        didSet {
            if actualRecipeArray.count == 0 {
                          cartView.removeFromSuperview()
                          view.addSubview(emptyCart)
                          navigationItem.title = "There Are Zero Items In Your Cart"
                      } else {
                              emptyCart.removeFromSuperview()
                              view.addSubview(cartView)
                          cartView.cartTable.reloadData()
                                         setNavigationTitle()
                          }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         setUpRecipeArray()
    }
    
    private func setUpRecipeArray() {
        do { try
      filteredRecipeArray = Array(Set(RecipePersistenceManager.manager.getSavedRecipes()))
          try  actualRecipeArray = RecipePersistenceManager.manager.getSavedRecipes()
        } catch {
            print(error)
        }
    }
    
 
   
    
    private func setNavigationTitle() {
        navigationItem.title = "\(actualRecipeArray.count) Item(s)"
    }
    
    private func setDelegates() {
        cartView.cartTable.delegate = self
        cartView.cartTable.dataSource = self
    }

}
extension CartViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredRecipeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }

       // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartView.cartTable.dequeueReusableCell(withIdentifier: RegisterCollectionViewCells.cart.rawValue) as? CartTableViewCell else
             {return UITableViewCell()}
            
        let currentRecipe = filteredRecipeArray[indexPath.section]
             
        cell.backgroundColor = UIColor.white
              cell.layer.borderColor = UIColor.black.cgColor
              cell.layer.borderWidth = 1
              cell.layer.cornerRadius = 5
              cell.clipsToBounds = true
        
        cell.foodLabel.text = currentRecipe.title
        cell.countLabel.text = "\(actualRecipeArray.filter({$0.id == currentRecipe.id}).count) In Cart"
       
        
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
        } else {
            cell.foodImageView.image = UIImage(systemName: "photo")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = cartView.cartTable.cellForRow(at: indexPath) as? CartTableViewCell else {return}
        let detailVC = DetailRecipeViewController()
        
                   detailVC.recipeImage = selectedCell.foodImageView.image ?? UIImage(named:"Italian")!
        detailVC.recipe = filteredRecipeArray[indexPath.section]
                   navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
