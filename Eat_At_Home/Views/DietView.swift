//
//  DietView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/30/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class DietView: UIView {
    
     lazy var dietLabel:UILabel =
           {
               let label = UILabel()
               label.textAlignment = .center
               label.adjustsFontSizeToFitWidth = true
               label.numberOfLines = 0
               label.text = "Diet Options"
               label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
               label.textColor = StyleGuide.FontStyle.fontColor
               return label
       }()

    lazy var dietCollectionView:UICollectionView =
        {
            let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
            let diet:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            diet.register(DietCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.diet.rawValue)
            diet.backgroundColor = .clear
            
            return diet
    }()
   
         
    override init(frame: CGRect) {
        super.init(frame: frame )
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        dietLabelConstraints()
        dietCollectionConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
       
    }
    
    private func addSubviews() {
        self.addSubview(dietLabel)
        self.addSubview(dietCollectionView)
    }
    
    private func dietLabelConstraints()
    {
        dietLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dietLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dietLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            dietLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            dietLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func dietCollectionConstraints() {
        dietCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dietCollectionView.topAnchor.constraint(equalTo: dietLabel.bottomAnchor,constant: UIScreen.main.bounds.maxX * 0.025),
            dietCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dietCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dietCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
