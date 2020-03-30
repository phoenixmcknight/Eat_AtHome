

import UIKit

class SearchRecipeSettingsCollectionViewCell: UICollectionViewCell {
 
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
    
      required init?(coder: NSCoder)
      {
          fatalError("init(coder:) has not been implemented")
      }
      
      override init(frame: CGRect)
      {
          super.init(frame: frame)
        commonInit()
      }
    
    private func commonInit()
    {
        addSubviews()
        foodLabelConstraints()
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    private func addSubviews()
    {
        self.addSubview(foodLabel)
    }
    
   
    
    private func foodLabelConstraints()
    {
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           
            foodLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foodLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            foodLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
