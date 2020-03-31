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
        
        weak var delegate:CaloriesDelegate?
        
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
            
            
            let calorieArray = [("Snack", 100),("Light Meal",300),("Average Meal",500),("Heavy Meal",850),("Are You Sure About That?", 1200),("Slow Down, Buddy", 1500),("Just Go For It",2500)]
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

            guard let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "generic") else {return UITableViewCell()}

            let genericCalorie = genericCalories[indexPath.section]
            
            cell.textLabel?.text = genericCalorie.0 + " - \(genericCalorie.1) Calories"

            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let selectedCell = tableView.cellForRow(at: indexPath)
            
            for cell in 0...6 {
                if tableView.cellForRow(at: IndexPath(row: 0, section: cell)) == selectedCell {
                    selectedCell?.layer.borderColor = UIColor.green.cgColor
                    selectedCell?.layer.borderWidth = 5
                } else {
                    tableView.cellForRow(at: IndexPath(row: 0, section: cell))?.layer.borderColor = UIColor.black.cgColor
                    tableView.cellForRow(at: IndexPath(row: 0, section: cell))?.layer.borderWidth = 1
                }
            }
            
            delegate?.sendCalories(calories: genericCalories[indexPath.section].1)
         
         
        }
        
    }
