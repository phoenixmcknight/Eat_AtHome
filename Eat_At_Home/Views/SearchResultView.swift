//
//  SearchResultView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class SearchResultView: UIView {
    
    
    lazy var mainSearchRecipeBar:UISearchBar =
        {
        let main = UISearchBar()
            main.placeholder = "Search With Current Filters"
            return main
    }()

    lazy var resultCollectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
                             
                             layout.scrollDirection = .vertical
                             let result = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
                             result.backgroundColor = .clear
                 result.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.result.rawValue)
                             return result
    }()
    
    lazy var viewForSearchTerm:UIView = {
        let view = UIView()
        view.backgroundColor = StyleGuide.AppColors.accentColor
    
        return view
    }()
    
    lazy var queryLabel:UILabel = {
         let label = UILabel()
            //label.textAlignment = .center
        label.text = "Search: Pizza"
                 label.adjustsFontSizeToFitWidth = true
                 label.numberOfLines = 0
                 label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
                 label.textColor = StyleGuide.FontStyle.fontColor
        return label
    }()
    
    lazy var buttonOne:UIButton = {
       let button = UIButton()
        button.setTitle("Newest", for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
               button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        return button
    }()
    
    lazy var buttonTwo:UIButton = {
          let button = UIButton()
           button.setTitle("Price", for: .normal)
           button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
                  button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
           return button
       }()
    
    lazy var customActivityIndictator = CustomIndictator(frame: .zero)

    
    lazy var buttonStackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.buttonOne,self.buttonTwo])
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        viewSearchTermConstraints()
        queryLabelConstraints()
        buttonStackConstraints()
        resultCollectionViewConstraints()
        customActivityIndictator.setToCenter(view: self, sizeRelativeToView: 0.2)
        self.setGradientBackground(colorTop: StyleGuide.AppColors.backgroundColor, colorBottom: StyleGuide.AppColors.accentColor)
    }
    
    private func addSubviews() {
        self.addSubview(viewForSearchTerm)
        viewForSearchTerm.addSubview(queryLabel)
        viewForSearchTerm.addSubview(buttonStackView)
        self.addSubview(resultCollectionView)
    }
    
    private func  viewSearchTermConstraints() {
        viewForSearchTerm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForSearchTerm.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            viewForSearchTerm.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewForSearchTerm.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewForSearchTerm.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func queryLabelConstraints() {
        queryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            queryLabel.topAnchor.constraint(equalTo: viewForSearchTerm.topAnchor,constant: viewForSearchTerm.frame.height * 0.05),
            queryLabel.leadingAnchor.constraint(equalTo: viewForSearchTerm.leadingAnchor,constant: self.frame.height * 0.01),
            queryLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            queryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func buttonStackConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: queryLabel.bottomAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: viewForSearchTerm.centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            buttonStackView.heightAnchor.constraint(equalTo: queryLabel.heightAnchor)
        ])
    }
    private func resultCollectionViewConstraints() {
        resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultCollectionView.topAnchor.constraint(equalTo: viewForSearchTerm.bottomAnchor),
            resultCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resultCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            resultCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
