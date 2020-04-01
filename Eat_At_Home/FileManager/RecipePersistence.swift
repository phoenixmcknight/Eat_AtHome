

import Foundation

struct RecipePersistenceManager {
    static let manager = RecipePersistenceManager()

    func save(newRecipe: Recipe) throws {
        try persistenceHelper.save(newElement: newRecipe)
    }

    func getSavedRecipes() throws -> [Recipe] {

        return try persistenceHelper.getObjects()
    }

    func deleteRecipe(recipeID:Int) throws {
        do {
//            var letNewRecipeArray = try getSavedRecipes().filter({$0.id != recipeID})
             var letNewRecipeArray = try getSavedRecipes()
           
            for (i,v) in letNewRecipeArray.enumerated() {
                if v.id == recipeID {
                letNewRecipeArray.remove(at: i)
                    break
                }
            }
            try persistenceHelper.replace(elements: letNewRecipeArray)

        } catch {
            print(error)
        }
    }
   func replaceAllFunction(newRecipe:[Recipe]) throws {
        do {
            try persistenceHelper.replace(elements: newRecipe)
            
        }
    }

    private let persistenceHelper = PersistenceHelper<Recipe>(fileName: "recipe.plist")

    private init() {}
}

