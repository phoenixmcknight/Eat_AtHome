//
//  StepTextViewAndLabel.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 7/8/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class StepView: UIView {

     lazy var stepLabel:UILabel = {
      let label =  UILabel(text: "2",fontsize:18)
        label.sizeToFit()
        return label
      }()
      
      lazy var stepNumberLabel:UILabel = {
          let label =  UILabel(text: "2",fontsize:12)
          return label
      }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
          addSubviews()
          configureNumberLabel()
          configureStepTextView()
          self.backgroundColor = .clear
      }

      
      private func addSubviews() {
         self.addSubview(stepNumberLabel)
          self.addSubview(stepLabel)
      }
    
    private func configureNumberLabel() {
           stepNumberLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               stepNumberLabel.topAnchor.constraint(equalTo: self.topAnchor),
               stepNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               stepNumberLabel.heightAnchor.constraint(equalToConstant:20 ),
               stepNumberLabel.widthAnchor.constraint(equalToConstant: 40)
           ])
       }
       
       private func configureStepTextView() {
           stepLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: stepNumberLabel.bottomAnchor),
            stepLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:self.frame.width * 0.05),
               stepLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-(self.frame.width * 0.05)),
               stepLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
           ])
       }
}
