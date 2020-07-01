import UIKit

protocol SearchResultCellDelegate:AnyObject {
    func navigateToDetailVC(tag:Int)
}

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    weak var delegate:SearchResultCellDelegate?
    
   lazy var foodImageView:UIImageView =
          {
           let image = UIImageView()
              image.contentMode = .scaleToFill
              image.layer.shadowColor = UIColor.black.cgColor
              image.layer.shadowRadius = 5.0
              image.layer.shadowOpacity = 10
              return image
      }()
    
    lazy var starRatingImageView:UIImageView =
        {
            let image = UIImageView()
            image.contentMode = .scaleToFill
            image.image = UIImage(named: "stars_0")
                        return image
    }()
    
    lazy var recipeTitleLabel:UILabel = {
        let label = UILabel(text: "Food Title Label",fontsize:12)
        return label
    }()
    
    lazy var ratingsLabel:UILabel = {
        let label = UILabel(text: "Ratings Label",fontsize:12)
        return label
    }()
    
    lazy var servingsLabel:UILabel = {
        let label  = UILabel(text: "Submitted By",fontsize:12)
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel(text: "",fontsize:12)
        
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    lazy var viewRecipeButton:UIButton = {
    let button = UIButton()
        button.setTitle("Click To See More", for: .normal)
             button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
             button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size:  22)
             button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
             button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
             button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var imageActivityIndc:UIActivityIndicatorView = {
           let act = UIActivityIndicatorView()
           act.hidesWhenStopped = true
           act.style = .large
           act.startAnimating()
           return act
       }()
    
    
    
    private var distanceFromEdge:CGFloat = 0
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()
        configureCell(with: .none, itemNumber: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func commonInit() {
        addSubviews()
        distanceFromEdge = self.frame.height * 0.05
        foodImageConstraint()
        activityIndcConstraints()
        recipeLabelConstraints()
        ratingImageViewConstraints()
        ratingsLabelConstraints()
        submittedByLabelConstraints()
        descriptionLabelConstraints()
        recipeButtonConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    
    public func configureCell(with recipe:Recipe?,itemNumber:Int?) {
        guard let recipe = recipe else {
            imageActivityIndc.stopAnimating()
           return}
        
        descriptionLabel.text = recipe.formattedSummary
              
              starRatingImageView.image = RatingsModel.shared.returnCorrectStarImage(score: recipe.spoonacularScore ?? 0)
              
             
            ratingsLabel.text = "\(recipe.spoonacularScore ?? 0)"
              
              
              recipeTitleLabel.text = recipe.title
              
              if let servings = recipe.servings {
                   servingsLabel.text = "Servings: \(servings)"
              } else {
                  servingsLabel.text = "Servings: Unavailable"
              }
              viewRecipeButton.tag = itemNumber!
        
             imageActivityIndc.startAnimating()
              
              if let imageURL = recipe.image {
              
                if let cachedImage = ImageHelper.shared.image(forKey: imageURL as NSString) {
                    foodImageView.image = cachedImage
                } else {
                
              ImageHelper.shared.getImage(urlStr: imageURL  ) { [weak self] (result) in
                  DispatchQueue.main.async {
                      switch result {
                      case .failure(_):
                        self?.foodImageView.image = UIImage(systemName: "photo")!
                        self?.imageActivityIndc.stopAnimating()
                      case .success(let image):
                        
                        self?.foodImageView.image = image
                        self?.imageActivityIndc.stopAnimating()
                      }
                  }
              }
              }
              } else {
                foodImageView.image = UIImage(systemName: "photo")
        }
    }
    
    private func addSubviews() {
        self.addSubview(foodImageView)
        foodImageView.addSubview(imageActivityIndc)
        self.addSubview(recipeTitleLabel)
        self.addSubview(starRatingImageView)
        self.addSubview(ratingsLabel)
        self.addSubview(servingsLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(viewRecipeButton)
    }
    
    private func foodImageConstraint() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: distanceFromEdge),
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: distanceFromEdge),
            foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.4),
            foodImageView.widthAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.4)
        ])
    }
    
    @objc private func buttonTapped(sender:UIButton) {
        delegate?.navigateToDetailVC(tag: sender.tag)
    }
    
    private func recipeLabelConstraints() {
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: distanceFromEdge),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
            recipeTitleLabel.heightAnchor.constraint(equalTo: foodImageView.heightAnchor, multiplier: 0.3),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -distanceFromEdge)
        ])
    }
    
    private func ratingImageViewConstraints() {
        starRatingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starRatingImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
//            starRatingImageView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor,constant: self.frame.width * 0.05),
           
            starRatingImageView.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            starRatingImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            
            starRatingImageView.widthAnchor.constraint(equalTo: recipeTitleLabel.widthAnchor, multiplier: 0.5)
        ])
    }
    private func ratingsLabelConstraints() {
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingsLabel.topAnchor.constraint(equalTo: starRatingImageView.bottomAnchor),
            ratingsLabel.centerXAnchor.constraint(equalTo: starRatingImageView.centerXAnchor),
            ratingsLabel.heightAnchor.constraint(equalTo: starRatingImageView.heightAnchor,multiplier: 1.5),
            ratingsLabel.widthAnchor.constraint(equalTo: starRatingImageView.widthAnchor)
        ])
    }
    
    private func submittedByLabelConstraints() {
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            servingsLabel.topAnchor.constraint(equalTo: ratingsLabel.bottomAnchor),
          //  submittedByLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
         //   submittedByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: distanceFromEdge),
            servingsLabel.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            servingsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            servingsLabel.heightAnchor.constraint(equalTo: ratingsLabel.heightAnchor)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor,constant: distanceFromEdge),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: distanceFromEdge),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -distanceFromEdge),
            descriptionLabel.heightAnchor.constraint(equalTo: foodImageView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func recipeButtonConstraints() {
        viewRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewRecipeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            viewRecipeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewRecipeButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.6),
            //viewRecipeButton.heightAnchor.constraint(equalTo: titleUILabel.heightAnchor, constant: 0.8)
            viewRecipeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -distanceFromEdge)
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
