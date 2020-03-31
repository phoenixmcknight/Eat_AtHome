//
//  ReadyTimeView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class TimeAndNumberSettingsView: UIView {

    lazy var timeAndNumberTableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = StyleGuide.AppColors.backgroundColor
               
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "generic")
              
        tableView.backgroundColor = StyleGuide.AppColors.backgroundColor
        return tableView
    }()
     
    override init(frame:CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        addSubviews()
        timeAndNumberTableViewConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    private func addSubviews() {
        self.addSubview(timeAndNumberTableView)
    }
   
    private func timeAndNumberTableViewConstraints() {
        timeAndNumberTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeAndNumberTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: UIScreen.main.bounds.height * 0.01),
            timeAndNumberTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: UIScreen.main.bounds.height * 0.01),
            timeAndNumberTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -UIScreen.main.bounds.height * 0.01),
            timeAndNumberTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}


