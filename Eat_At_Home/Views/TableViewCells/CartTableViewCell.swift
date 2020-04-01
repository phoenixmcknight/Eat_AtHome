//
//  CartTableViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 4/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {


    lazy var foodImageView:UIImageView =
          {
           let image = UIImageView()
              image.contentMode = .scaleToFill
             
              image.layer.shadowColor = UIColor.black.cgColor
              image.layer.shadowRadius = 5.0
              image.layer.shadowOpacity = 10
              return image
      }()
      
      lazy var foodLabel:UILabel =
          {
              let label = UILabel()
              label.textAlignment = .center
              label.adjustsFontSizeToFitWidth = true
              label.numberOfLines = 0
              label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
              label.textColor = StyleGuide.FontStyle.fontColor
              return label
      }()
    
    lazy var countLabel:UILabel = {
        let count = UILabel(text: "", fontsize: StyleGuide.FontStyle.fontSize)
        return count
    }()
    

    
    lazy var imageActivityIndc:UIActivityIndicatorView = {
             let act = UIActivityIndicatorView()
             act.hidesWhenStopped = true
             act.style = .large
             act.startAnimating()
             return act
         }()
      

     
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
          super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
      }
      
      required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
   
    private func commonInit() {
        addSubviews()
        foodImageConstraints()
        activityIndcConstraints()
        foodLabelConstraints()
        countLabelConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(foodImageView)
        self.addSubview(imageActivityIndc)
        self.addSubview(foodLabel)
        self.addSubview(countLabel)
    }
    
  private func foodImageConstraints()
       {
           foodImageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               foodImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5),
               foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
               
           ])
       }
       
       private func foodLabelConstraints()
       {
           foodLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               foodLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
               foodLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               foodLabel.topAnchor.constraint(equalTo: self.topAnchor),
               foodLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
           ])
       }
    
    private func countLabelConstraints() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
               
        NSLayoutConstraint.activate([
                     countLabel.centerXAnchor.constraint(equalTo: foodLabel.centerXAnchor),
                     countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                     countLabel.heightAnchor.constraint(equalTo: foodLabel.heightAnchor),
                     countLabel.widthAnchor.constraint(equalTo: foodLabel.widthAnchor)
                 ])
    }
       private func activityIndcConstraints() {
              imageActivityIndc.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([

               imageActivityIndc.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
               imageActivityIndc.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
              ])
          }
       

}
