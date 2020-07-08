
import UIKit

class DetailRecipeViewController: UIViewController {

    let detailRecipeView = DetailRecipeView()
    var recipeImage:UIImage!
    var recipe:Recipe!
    var ingredients:[Ingredients] = []
    var savedRecipes:Dictionary<String,String>!
    var isSaving:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(detailRecipeView)
      configureDetailVC()
    
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    private func setDelegates() {
        detailRecipeView.ingredientCollectionView.dataSource = self
        detailRecipeView.ingredientCollectionView.delegate = self
        
    }
    
    private func configureDetailVC() {
        ingredients = recipe.returnIngredientList()
             setDelegates()
              detailRecipeView.configureView(with: recipeImage, recipe: recipe)
              savedRecipes = UserDefaultsWrapper.shared.getRecipeDict() ?? Dictionary<String,String>()
          configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(favoriteRecipe))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func favoriteRecipe() {
        guard !isSaving else {return}
        isSaving = true
       
        guard savedRecipes["\(recipe.id)"] == nil else {
            showAlert(title: "Error", message: "Recipe Already Saved")
        isSaving = false
            return
        }
        
        do {
            try
         RecipePersistenceManager.manager.save(newRecipe: recipe)
            savedRecipes["\(recipe.id)"] = "Saved"
            UserDefaultsWrapper.shared.store(recipeList: savedRecipes)
            isSaving = false
            showAlert(title: "Success", message: "Saved \(recipe.title?.capitalized ?? "")")
        } catch {
            showAlert(title: "Error", message: "Failed To Save Recipe. Please Try Again")
            isSaving = false
        }
         
        }
    
   
}


extension DetailRecipeViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViewCells.ingredients.rawValue, for: indexPath) as? IngredientsCollectionViewCell else {return UICollectionViewCell()}
        cell.configureCell(with: ingredients[indexPath.item])
        
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: detailRecipeView.ingredientCollectionView.frame.height * 0.50, height: detailRecipeView.ingredientCollectionView.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
