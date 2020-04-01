//
//  CartView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class CartView: UIView {

   lazy var cartTable: UITableView = {
           let tableview = UITableView()
           tableview.backgroundColor = StyleGuide.AppColors.backgroundColor
           tableview.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    tableview.register(CartTableViewCell.self, forCellReuseIdentifier: RegisterCollectionViewCells.cart.rawValue)
          
           return tableview
          }()
    lazy var customActivityIndictator = CustomIndictator(frame: .zero)

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        addSubviews()
        tableViewConstraints()
        customActivityIndictator.setToCenter(view: self, sizeRelativeToView: 0.2)
    }
    private func addSubviews() {
        self.addSubview(cartTable)
    }
    
    private func tableViewConstraints() {
        cartTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartTable.topAnchor.constraint(equalTo: self.topAnchor),
            cartTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cartTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cartTable.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
