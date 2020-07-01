//
//  DishCollectionViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/29/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit


class DietCollectionViewController: UIViewController {
    
    var dietOptions:[String] = []
    let dietView = DietView()
     var onDoneBlock : ((Bool) -> Void)?
    
    weak var delegate:FilterDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dietView)
        addDelegates()
        
      

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      
        onDoneBlock!(true)
       
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addDelegates() {
        dietView.dietCollectionView.delegate = self
        dietView.dietCollectionView.dataSource = self
    }

    }


extension DietCollectionViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.50, height: view.frame.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
    }
    
    
}
extension DietCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of items
           return dietOptions.count
       }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.diet.rawValue, for: indexPath) as? FilterCollectionViewCell else {return UICollectionViewCell()}
           let currentItem = dietOptions[indexPath.item]
            cell.currentOption = currentItem
           cell.intoleranceActivityIndc.startAnimating()
            cell.dietFoodLabel.text = currentItem.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "+", with: " ")
            cell.dietImageView.image = UIImage(named: currentItem.replacingOccurrences(of: ",", with: ""))
            cell.intoleranceActivityIndc.stopAnimating()

           return cell
       }
       
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           guard let selectedDietOption = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell else {return}
           
            
            
           switch selectedDietOption.filterIsSelected {
           case false:
               selectedDietOption.filterIsSelected = true
               delegate?.sendFilter(addOrRemove: .add, filterString: selectedDietOption.currentOption, filterNumber: nil, filter: .diet)
           case true:
               selectedDietOption.filterIsSelected = false
                delegate?.sendFilter(addOrRemove: .remove, filterString: selectedDietOption.currentOption, filterNumber: nil, filter: .diet)
           }
           
}
}
