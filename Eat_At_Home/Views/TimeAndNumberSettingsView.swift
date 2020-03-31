//
//  ReadyTimeView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class TimeAndNumberSettingsView: UIView {

    lazy var readyTableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var numberPicker:UIPickerView = {
        let picker = UIPickerView()
        return picker
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
