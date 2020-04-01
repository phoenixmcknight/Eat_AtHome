//
//  EmptyCartView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class EmptyCartView: UIView {

    lazy var emptyCartImageView:UIImageView = {
       let empty = UIImageView()
        
        empty.image = UIImage(named: "empty_Cart")!
        empty.contentMode = .scaleAspectFill
        return empty
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview(emptyCartImageView)
        emptyCartConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func emptyCartConstraints() {
          emptyCartImageView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              emptyCartImageView.topAnchor.constraint(equalTo: self.topAnchor),
              emptyCartImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              emptyCartImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              emptyCartImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
          ])
      }
    
}
