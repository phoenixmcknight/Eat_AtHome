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
    
    
    lazy var ingredientCollectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
                   layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViewCells.ingredients.rawValue)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var scrollViewTest:UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    
    lazy var instructionLabel:UILabel = {
        let label = UILabel(text: "Instructions", fontsize: 12)
        return label
    }()
    
   lazy var stepArray:[UIView] = [self.instructionLabel]
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        addSubviews()
        scrollViewConstraints()
        foodImageViewConstraints()
        recipeTitleLabelConstraints()
        ingredientCollectionViewConstraints()
        instructionsLabelConstraints()
      //  stepsTableViewConstraints()
    self.backgroundColor = StyleGuide.AppColors.backgroundColor
    }
    
    func configureView(with image:UIImage,recipe:Recipe) {
        foodImageView.image = image
        recipeTitleLabel.text = recipe.title?.capitalized
        createSteps(with: recipe.analyzedInstructions[0].steps.count)
        setStepInformation(steps: recipe.analyzedInstructions[0].steps)
    }
    
    func createSteps(with steps:Int) {
        for i in 0...steps - 1 {
            let stepTextView = StepView()
            scrollViewTest.addSubview(stepTextView)
            configureStepView(with: stepTextView, precedingView: stepArray[i])
            stepArray.append(stepTextView)
        }
        stepArray.last?.bottomAnchor.constraint(equalTo: scrollViewTest.bottomAnchor).isActive = true
    }
    
    func setStepInformation(steps:[Step]) {
        for (index,view) in stepArray.enumerated() {
            if index == 0 {
                continue
            }
            guard let stepView = view as? StepView else {return}
            let step = steps[index - 1]
            stepView.stepNumberLabel.text = "Step \(step.number)"
            stepView.stepLabel.text = step.step
        }
    }
    
    private func configureStepView(with stepView:UIView,precedingView:UIView) {
        stepView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepView.topAnchor.constraint(equalTo: precedingView.bottomAnchor,constant:10),
        stepView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stepView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stepView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)
        ])
        
        
    }
    
    private func addSubviews(){
        self.addSubview(scrollViewTest)
        scrollViewTest.addSubview(foodImageView)
        scrollViewTest.addSubview(recipeTitleLabel)
        scrollViewTest.addSubview(ingredientCollectionView)
        scrollViewTest.addSubview(instructionLabel)
      
    }
    
   
    
    private func scrollViewConstraints() {
        scrollViewTest.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollViewTest.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollViewTest.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollViewTest.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollViewTest.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func foodImageViewConstraints() {
         foodImageView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: scrollViewTest.topAnchor),
             foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.3)
         ])
     }

     private func recipeTitleLabelConstraints() {
         recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             recipeTitleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor),
             recipeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             recipeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             recipeTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.025)
         ])
     }
    
    private func ingredientCollectionViewConstraints() {
        ingredientCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientCollectionView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
            ingredientCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ingredientCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ingredientCollectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func instructionsLabelConstraints() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: ingredientCollectionView.centerXAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            instructionLabel.topAnchor.constraint(equalTo: ingredientCollectionView.bottomAnchor),
            instructionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.025)
        ])
    }
}
