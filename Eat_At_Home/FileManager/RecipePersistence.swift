

import Foundation

struct VenueCollectionPersistenceManager {
    static let manager = VenueCollectionPersistenceManager()

    func save(newRecipe: Recipe) throws {
        try persistenceHelper.save(newElement: newRecipe)
    }

    func getSavedRecipes() throws -> [Recipe] {

        return try persistenceHelper.getObjects()
    }

    func deleteRecipe(recipeID:Int) throws {
        do {
            let letNewRecipeArray = try getSavedRecipes().filter({$0.id != recipeID})
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

