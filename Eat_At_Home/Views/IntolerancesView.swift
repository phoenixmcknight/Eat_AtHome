//
//  IntolerancesView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/30/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class IntolerancesView: UIView {

        
         lazy var intoleranceLabel:UILabel =
               {
                   let label = UILabel()
                   label.textAlignment = .center
                   label.adjustsFontSizeToFitWidth = true
                   label.numberOfLines = 0
                   label.text = "Intolerance Options"
                   label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
                   label.textColor = StyleGuide.FontStyle.fontColor
                   return label
           }()

        lazy var intoleranceCollectionView:UICollectionView =
            {
                let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                        layout.scrollDirection = .vertical
                let intolerance:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                intolerance.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.diet.rawValue)
                intolerance.backgroundColor = .clear
                
                return intolerance
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
            intoleranceLabelConstraints()
            intoleranceCollectionViewConstraints()
            self.backgroundColor = StyleGuide.AppColors.backgroundColor
            
        }
        
        private func addSubviews() {
            self.addSubview(intoleranceLabel)
            self.addSubview(intoleranceCollectionView)
        }
        
        private func intoleranceLabelConstraints()
        {
            intoleranceLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                intoleranceLabel.topAnchor.constraint(equalTo: self.topAnchor),
                intoleranceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
                intoleranceLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
                intoleranceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
        
        private func intoleranceCollectionViewConstraints() {
            intoleranceCollectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                intoleranceCollectionView.topAnchor.constraint(equalTo: intoleranceLabel.bottomAnchor,constant: UIScreen.main.bounds.maxX * 0.025),
                intoleranceCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                intoleranceCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                intoleranceCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
    }



