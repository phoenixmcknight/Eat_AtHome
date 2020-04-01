
import UIKit

class DetailRecipeViewController: UIViewController {

    let detailRecipeView = DetailRecipeView()
    var recipeImage:UIImage = UIImage()
    var recipe:Recipe!
    var oldValue:Double = 0
    lazy var customStepper = UIStepper (frame:CGRect(x: 110, y: 250, width: 0, height: 0))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(detailRecipeView)
      detailRecipeView.addSubview(customStepper)
      customStepperConstraints()
        setUpView()
       
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        returnCountOfRecipeInCart(recipeID: recipe.id)
         oldValue = customStepper.value
    }
    
    @objc func stepperValueChanged(sender:UIStepper!)
    {
        if sender.value > oldValue {
                   oldValue += 1
            checkCountOfRecipeInCart(recipeID: recipe.id)
            do {
                try RecipePersistenceManager.manager.save(newRecipe: recipe)
                self.showAlert(title: "+ 1", message: "You've Added \(recipe.title ?? "") To Your Cart")
            } catch {
            print(error)
            }
               } else {
                   oldValue -= 1
             self.showAlert(title: "- 1", message: "You've Removed \(recipe.title ?? "") From Your Cart")
                    do {
                        try RecipePersistenceManager.manager.deleteRecipe(recipeID: recipe.id)
                              } catch {
                              print(error)
                              }
               }
        
        
    }
    
    private func checkCountOfRecipeInCart(recipeID:Int) {
        do {
          let count =  try RecipePersistenceManager.manager.getSavedRecipes().filter({$0.id == recipeID}).count
            guard count <= 5 else {showAlert(title: "Slow Down", message: "You've Reached The Cart Limit For This Recipe")
                return
            }
        } catch {
            print(error)
        }
    }
    
    private func returnCountOfRecipeInCart(recipeID:Int) {
        do {
            customStepper.value = Double(try RecipePersistenceManager.manager.getSavedRecipes().filter({$0.id == recipeID}).count)
        } catch {
            print(error)
        }
    }

    private func customStepperConstraints() {
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            customStepper.bottomAnchor.constraint(equalTo: detailRecipeView.descriptionTextView.topAnchor),
            customStepper.leadingAnchor.constraint(equalTo: detailRecipeView.cartLabel.trailingAnchor),
            customStepper.trailingAnchor.constraint(equalTo: detailRecipeView.trailingAnchor)
            
        ])
    }

    private func setUpView() {
        detailRecipeView.foodImageView.image = recipeImage
        detailRecipeView.descriptionTextView.text = recipe.summary?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "/a>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "<a", with: "")
        detailRecipeView.recipeTitleLabel.text = recipe.title
        customStepper.wraps = false
              customStepper.autorepeat = false
              customStepper.maximumValue = 5
              customStepper.minimumValue = 0
              customStepper.value = 0
              customStepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        
    }
    
    
    
}
