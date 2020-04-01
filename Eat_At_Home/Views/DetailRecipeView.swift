import UIKit

class DetailRecipeView: UIView {

    lazy var foodImageView:UIImageView =
             {
              let image = UIImageView()
                 image.contentMode = .scaleToFill
                
                 image.layer.shadowColor = UIColor.black.cgColor
                 image.layer.shadowRadius = 5.0
                 image.layer.shadowOpacity = 10
                 return image
         }()
       
       lazy var recipeTitleLabel:UILabel = {
           let label = UILabel(text: "Food Title Label",fontsize:12)
           return label
       }()

       
       lazy var cartLabel:UILabel = {
           let label  = UILabel(text: "Add Or Remove From Cart",fontsize:14)
           return label
       }()
       
       lazy var descriptionTextView:UITextView = {
        let descriptionView = UITextView()
        descriptionView.font = UIFont(name: StyleGuide.FontStyle.fontName, size: 15)
        descriptionView.backgroundColor = StyleGuide.AppColors.backgroundColor
        
           
           return descriptionView
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
        foodImageViewConstraints()
        recipeTitleLabelConstraints()
        cartLabelConstraints()
        descriptionTextViewConstraints()
    self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    
    private func addSubviews(){
        self.addSubview(foodImageView)
        self.addSubview(recipeTitleLabel)
        self.addSubview(cartLabel)
        self.addSubview(descriptionTextView)
    }
    
   
    private func foodImageViewConstraints() {
         foodImageView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             foodImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
             foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.4)
         ])
     }

     private func recipeTitleLabelConstraints() {
         recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             recipeTitleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor),
             recipeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             recipeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             recipeTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.02)
         ])
     }


     private func cartLabelConstraints() {
         cartLabel.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             cartLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
             cartLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             cartLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
             cartLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
         ])
     }

     private func descriptionTextViewConstraints() {
         descriptionTextView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             descriptionTextView.topAnchor.constraint(equalTo: cartLabel.bottomAnchor),
             descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

         ])
     }
    

}
