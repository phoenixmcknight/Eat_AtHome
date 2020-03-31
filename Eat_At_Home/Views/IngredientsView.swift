//
//  IncludeIngredientsView.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/30/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class ingredientsView: UIView {

    lazy var ingredientsTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add Ingredients"
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var outletArray:[UIView] = [self.ingredientsTextField]
    
    weak var delegate:IncludeIngredientDelegate?
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit()
    {
        addSubviews()
        ingredientTextFieldConstraints()
        self.backgroundColor = .white
    }
    
    private func addSubviews() {
        self.addSubview(ingredientsTextField)
    }
    private func configureStackView(newLabel:UIView,newImageView:UIImageView) -> UIStackView {
       let newStackView = UIStackView(arrangedSubviews: [newImageView,newLabel])
        
        newStackView.axis = .horizontal
        newStackView.spacing = 5
        newStackView.contentMode = .center
        return newStackView
    }
    
    private func configureNewView() -> UIView {
       
        let newView = UIView()
        
        newView.isUserInteractionEnabled = true
               let tapGesture:UITapGestureRecognizer = {
                   let tap = UITapGestureRecognizer()
                   tap.addTarget(self, action: #selector(clickToRemoveTapGesture(sender:)))
                   return tap
               }()
               let panGesture:UIPanGestureRecognizer = {
                   let pan = UIPanGestureRecognizer()
                   pan.addTarget(self, action: #selector(panGesture(sender:)))
                   return pan
               }()
               newView.addGestureRecognizer(tapGesture)
               newView.addGestureRecognizer(panGesture)
        
        newView.translatesAutoresizingMaskIntoConstraints = false
             
       
        
        newView.layer.borderWidth = 5
        newView.layer.borderColor = UIColor.green.cgColor
        return newView
    }
    
    private func newViewConstraints(newView:UIView,lastOutlet:UIView) {
        NSLayoutConstraint.activate([
               newView.topAnchor.constraint(equalTo: lastOutlet.bottomAnchor),
               newView.centerXAnchor.constraint(equalTo: lastOutlet.centerXAnchor),
               newView.heightAnchor.constraint(equalTo: ingredientsTextField.heightAnchor),
                newView.widthAnchor.constraint(equalTo: ingredientsTextField.widthAnchor, multiplier: 0.8)
               
               ])
    }
    
    private func newImageViewConstraints(newImageView:UIImageView) {
     
        NSLayoutConstraint.activate([
               newImageView.heightAnchor.constraint(equalTo: ingredientsTextField.heightAnchor),
               newImageView.widthAnchor.constraint(equalTo: ingredientsTextField.widthAnchor, multiplier: 0.2)
              ])
    }
    
    private func configureNewLabel(ingredientName:String) -> UILabel
    {
        let newLabel = UILabel()
         
        newLabel.text = ingredientName
        return newLabel
    }
    private func confingureNewImageView(ingredientName:String) -> UIImageView
    {
        let activity = UIActivityIndicatorView()
                  activity.hidesWhenStopped = true
                  activity.contentMode = .center
                  activity.style = .medium
                  activity.startAnimating()
      
        let newImageView = UIImageView()
        newImageView.contentMode = .scaleAspectFit
      
        newImageView.addSubview(activity)
        activity.center = newImageView.center
        
      
        
        ImageHelper.shared.getImage(urlStr: SpoonAPIClient.client.getIngredientImageURL(ingredientName: ingredientName.lowercased())) { (result) in
            DispatchQueue.main.async {
                
            
            switch result {
            case.failure(let error):
                print(error)
                activity.stopAnimating()
                
            case .success(let image):
                newImageView.image = image
                activity.stopAnimating()
            }
        }
        }
        return newImageView
    }
    
    
    
     public func createLabel(ingredientName:String,imageName:String)
    {
         guard let lastOutlet = outletArray.last else {return}
        guard outletArray.count <= 8 else {return}
     
        let newLabel = configureNewLabel(ingredientName: ingredientName)
        let newImageView = confingureNewImageView(ingredientName: ingredientName)
       let newView = configureNewView()
       let imageLabelStackView = configureStackView(newLabel: newLabel, newImageView: newImageView)
        imageLabelStackView.translatesAutoresizingMaskIntoConstraints = false
       newView.addSubview(imageLabelStackView)
       self.addSubview(newView)
        newImageViewConstraints(newImageView: newImageView)
        newViewConstraints(newView: newView, lastOutlet: lastOutlet)
        newLabel.heightAnchor.constraint(equalTo: ingredientsTextField.heightAnchor).isActive = true
        
       outletArray.append(newView)
     
        }
    
    @objc private func clickToRemoveTapGesture(sender:UIGestureRecognizer) {
         removeIngredient(sender: sender)
       }
    
    @objc private func panGesture(sender:UIPanGestureRecognizer)
                  
              {
                  
                  let card = sender.view
                  let pointer = sender.translation(in: self)
 
                  card?.center.x = self.center.x + pointer.x
                  
                  let xFromCenter = (card?.center.x)! - self.center.x
                  let rotation = (xFromCenter / (self.frame.width / 2)) * 0.93
                  // for full rotation make sure rotation value is over 1 (divide xFromCenter seperately)
                  let distanceFromCenterToTheRight = self.center.x  * 0.50
                  
                  let distanceFromCenterToTheLeft = self.center.x * -0.50
                  
                  let scaler = min(abs(80/xFromCenter), 1)
                  
                  card?.transform = CGAffineTransform(rotationAngle: rotation).scaledBy(x: scaler, y: scaler)
                  
                  if xFromCenter > 0 {
                      card?.layer.borderWidth = 5
                      card?.layer.borderColor = UIColor.red.withAlphaComponent(abs(xFromCenter / self.center.x)).cgColor
                      
                      
                  } else if xFromCenter < 0 {
                      card?.layer.borderWidth = 5
                      card?.layer.borderColor = UIColor.red.withAlphaComponent(abs(xFromCenter / self.center.x)).cgColor
                  }
                  
                  if sender.state == .ended {
                      
                      if xFromCenter > 0 && xFromCenter < distanceFromCenterToTheRight {
                          
                          UIView.animate(withDuration: 0.2) {
                               card?.layer.borderColor = UIColor.green.cgColor
                            
                            card?.center.x = self.ingredientsTextField.center.x
                            
                              card?.transform = .identity
                            
                          }
                          return
                      } else if xFromCenter < 0 && xFromCenter > distanceFromCenterToTheLeft {
                          
                          UIView.animate(withDuration: 0.2) {
                            card?.center.x = self.ingredientsTextField.center.x
                           
                            card?.layer.borderColor = UIColor.green.cgColor
                            
                              card?.transform = .identity
           
                          }
                          return
                      } else if xFromCenter >= distanceFromCenterToTheRight {
                          
                          UIView.animate(withDuration: 0.5, animations: {
                              card?.center = CGPoint(x: self.frame.maxX + (self.frame.width * 0.5), y: (card?.center.y)! + (card?.superview?.frame.height)! * 0.05)
                            
                            self.removeIngredient(sender: sender)
                           
                          })
                        
                          return
                      } else if xFromCenter <= distanceFromCenterToTheLeft
                      {
                          UIView.animate(withDuration: 0.5, animations: {
                              
                              card?.center = CGPoint(x: self.frame.maxX - (self.frame.width * 1.5), y: ((card?.center.y)!) + (card?.superview?.frame.height)! * 0.05)
                            
                            self.removeIngredient(sender: sender)
                          })
                       
                          return
                      }
                  }
              }
    
    private func removeIngredient(sender:UIGestureRecognizer) {
        guard outletArray.count > 1 else {return}
               guard let currentOutlet = outletArray.firstIndex(where: {$0 == sender.view} ) else {return}
        
        guard let selectedLabel = outletArray[currentOutlet].subviews[0].subviews[1] as? UILabel else {return}
        guard let ingredientText = selectedLabel.text else {return}
        
        
               if outletArray[currentOutlet] == outletArray.last {
               outletArray[currentOutlet].removeFromSuperview()
                
                
                
                delegate?.sendIngredient(isAdding: false, ingredient: ingredientText)
               outletArray.remove(at: currentOutlet)
               } else {
                   let index = currentOutlet as! Int
                 outletArray[currentOutlet].removeFromSuperview()
                delegate?.sendIngredient(isAdding: false, ingredient: ingredientText)
                 outletArray.remove(at: currentOutlet)
               outletArray[index].topAnchor.constraint(equalTo: outletArray[index - 1].bottomAnchor).isActive = true
                   outletArray[index].centerXAnchor.constraint(equalTo: outletArray[index - 1].centerXAnchor).isActive = true
    }
    }
    
    private func ingredientTextFieldConstraints() {
        
        ingredientsTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsTextField.topAnchor.constraint(equalTo: self.topAnchor,constant: self.frame.height * 0.025),
            ingredientsTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ingredientsTextField.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
        ])
    }
    
    
}
