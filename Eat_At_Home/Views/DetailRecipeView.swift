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
       
    lazy var cartStepper:UIStepper = {
        let step = UIStepper()
        step.isUserInteractionEnabled = true
        step.minimumValue = 0
        step.maximumValue = 5
        step.wraps = false
        step.autorepeat = true
       
        return step
    }()
       
       lazy var cartLabel:UILabel = {
           let label  = UILabel(text: "Items In Cart: ",fontsize:12)
           return label
       }()
       
       lazy var descriptionTextView:UITextView = {
        let descriptionView = UITextView()
           
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
        foodImageConstraints()
        recipeTitleLabelConstraints()
        cartLabelConstraints()
       stepperConstraints()
       descriptionConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor

    }
 
    
    private func addSubviews(){
        self.addSubview(foodImageView)
        self.addSubview(recipeTitleLabel)
        self.addSubview(cartLabel)
        self.addSubview(cartStepper)
        self.addSubview(descriptionTextView)
    }
    
    
    private func foodImageConstraints() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: self.frame.height * 0.01),
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
    
    private func stepperConstraints() {
        cartStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartStepper.leadingAnchor.constraint(equalTo: cartLabel.trailingAnchor,constant: 5),
            cartStepper.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.025),
            cartStepper.centerYAnchor.constraint(equalTo: cartLabel.centerYAnchor),
            cartStepper.heightAnchor.constraint(equalTo: cartLabel.heightAnchor,multiplier: 0.6)
        ])
    }
    
    
    private func descriptionConstraints() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: cartStepper.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
}
