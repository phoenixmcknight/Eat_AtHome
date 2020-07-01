//
//  ReadyTimeViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class ReadyTimeViewController: UIViewController {
    
    
    let cellSpacingHeight: CGFloat = 10
    
    weak var delegate:FilterDelegate?
    
    var genericTimes:[(String,Int)] = [] {
        didSet {
            readyTimeView.timeAndNumberTableView.reloadData()
        }
    }

      var onDoneBlock : ((Bool) -> Void)?
    
    let readyTimeView = TimeAndNumberSettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(readyTimeView)
        giveValueToGenericTimes()
        addDelegates()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onDoneBlock!(true)
    }
    
    private func giveValueToGenericTimes() {
        
        
        let timeArray = [("Really Fast", 5),("Quick",15),("Medium",30),("Long",60),("Really Long", 90),("Gordan Ramsey", 120),("Time is an Illusion",6000)]
        genericTimes = timeArray
    }
    
    private func addDelegates() {
        readyTimeView.timeAndNumberTableView.delegate = self
        readyTimeView.timeAndNumberTableView.dataSource = self
    }
}


extension ReadyTimeViewController:UITableViewDelegate,UITableViewDataSource{
   func numberOfSections(in tableView: UITableView) -> Int {
        return genericTimes.count
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

        let genericTime = genericTimes[indexPath.section]
        
        cell.textLabel?.text = genericTime.0 + " - \(genericTime.1) Minutes"

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
        
        delegate?.sendFilter(addOrRemove: .add, filterString: nil, filterNumber: genericTimes[indexPath.section].1, filter: .time)
    
     
     
    }
    
}

