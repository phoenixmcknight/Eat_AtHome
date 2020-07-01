//
//  CaloriesViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class CaloriesViewController: UIViewController {
     
        let cellSpacingHeight: CGFloat = 10
        
        weak var delegate:FilterDelegate?
        
        var genericCalories:[(String,Int)] = [] {
            didSet {
                caloriesView.timeAndNumberTableView.reloadData()
            }
        }

          var onDoneBlock : ((Bool) -> Void)?
        
        let caloriesView = TimeAndNumberSettingsView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(caloriesView)
            giveValueToGenericTimes()
            addDelegates()
            // Do any additional setup after loading the view.
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDoneBlock!(true)
        }
        
        private func giveValueToGenericTimes() {
            
            
            let calorieArray = [("Snack", 100),("Light Meal",300),("Average Meal",500),("Heavy Meal",850),("Heavy Meal+", 1200)]
            genericCalories = calorieArray
        }
        
        private func addDelegates() {
            caloriesView.timeAndNumberTableView.delegate = self
            caloriesView.timeAndNumberTableView.dataSource = self
        }
    }


    extension CaloriesViewController:UITableViewDelegate,UITableViewDataSource{
       func numberOfSections(in tableView: UITableView) -> Int {
            return genericCalories.count
        }

        // There is just one row in every section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        // Set the spacing between sections
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }

        // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }

        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "generic") as? CalorieAndTimeFilterTableViewCell else {return UITableViewCell()}

            let genericCalorie = genericCalories[indexPath.section]
            
            cell.textLabel?.text = genericCalorie.0 + " - \(genericCalorie.1) Calories"

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            guard let selectedCell = tableView.cellForRow(at: indexPath) as? CalorieAndTimeFilterTableViewCell else {return}
            
            
            switch selectedCell.hasBeenSelected {
            case true:
                delegate?.sendFilter(addOrRemove: .remove, filterString: nil, filterNumber: genericCalories[indexPath.section].1, filter: .calories)
            case false:
                delegate?.sendFilter(addOrRemove: .add, filterString: nil, filterNumber: nil, filter: .calories)
            }
            
            delegate?.sendFilter(addOrRemove: .add, filterString: nil, filterNumber: genericCalories[indexPath.section].1, filter: .calories)
        }
        
    }

extension CaloriesViewController {
    func configureTableViewCell(cell:UITableViewCell) {
        
    }
}
