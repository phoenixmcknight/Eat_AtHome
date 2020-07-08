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
    var savedRecipeIDS:Dictionary<String,String>!
    var recipeArray:[Recipe] = [] {
        didSet {
            guard !recipeArray.isEmpty else {
                cartView.removeFromSuperview()
                                         view.addSubview(emptyCart)
                                         navigationItem.title = "There Are Zero Items In Your Cart"
                return
            }
        emptyCart.removeFromSuperview()
                                    view.addSubview(cartView)
                                cartView.cartTable.reloadData()
                                               setNavigationTitle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         setUpSavedRecipes()
    }
    
    private func setUpSavedRecipes() {
        do { try
            recipeArray = RecipePersistenceManager.manager.getSavedRecipes()
             savedRecipeIDS = UserDefaultsWrapper.shared.getRecipeDict() ?? Dictionary<String,String>()
        } catch {
            print(error)
        }
    }
    
 
   
    
    private func setNavigationTitle() {
        navigationItem.title = "\(recipeArray.count) Item(s)"
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
        return recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }

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
            
        let currentRecipe = recipeArray[indexPath.section]
             
        cell.backgroundColor = UIColor.white
              cell.layer.borderColor = UIColor.black.cgColor
              cell.layer.borderWidth = 1
              cell.layer.cornerRadius = 5
              cell.clipsToBounds = true
        
        cell.foodLabel.text = currentRecipe.title
                    
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
    
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == UITableViewCell.EditingStyle.delete {
        deleteRecipe(row: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
       }
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = cartView.cartTable.cellForRow(at: indexPath) as? CartTableViewCell else {return}
        let detailVC = DetailRecipeViewController()
        
                   detailVC.recipeImage = selectedCell.foodImageView.image ?? UIImage(systemName: "photo")!
        detailVC.recipe = recipeArray[indexPath.section]
                   navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
extension CartViewController {
    private func deleteRecipe(row:Int) {
        do {
            try RecipePersistenceManager.manager.deleteRecipe(recipeID: recipeArray[row].id)
            savedRecipeIDS["\(recipeArray[row].id)"] = nil
        } catch {
            showAlert(title: "Error", message: "Failed To Delete Recipe")
        }
    }
}
