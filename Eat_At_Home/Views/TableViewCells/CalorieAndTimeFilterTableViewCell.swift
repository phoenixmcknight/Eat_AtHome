//
//  CalorieAndTimeFilterTableViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 6/10/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class CalorieAndTimeFilterTableViewCell: UITableViewCell {

    var hasBeenSelected:Bool = false {
        didSet {
            cellHasBeenSelected()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        hasBeenSelected = false
    }
    
    public func cellHasBeenSelected() {
        
        switch hasBeenSelected {
        case false:
            self.layer.borderColor = UIColor.black.cgColor
        case true:
            self.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    private func configureCell() {
        self.backgroundColor = UIColor.white
              self.layer.borderColor = UIColor.black.cgColor
              self.layer.borderWidth = 2.5
              self.layer.cornerRadius = 5
              self.clipsToBounds = true
    }
}
