//
//  Eat_At_HomeTests.swift
//  Eat_At_HomeTests
//
//  Created by Phoenix McKnight on 3/26/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import XCTest
@testable import Eat_At_Home

class Eat_At_HomeTests: XCTestCase {

    var recipeData = Data()
    
    override func setUp() {
         guard let jsonPath = Bundle.main.path(forResource: "SpoonAPITestData", ofType: "json") else {
            XCTFail("Could not find event JSON file")
            return
        }
        let jsonURL = URL(fileURLWithPath: jsonPath)
          
          do {
            recipeData = try Data(contentsOf: jsonURL)
          } catch {
            XCTFail("\(error)")
          }
          // Put setup code here. This method is called before the invocation of each test method in the class.
        }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeRecipes() {
      var recipeArray = [Recipe]()
      
      do {
        let recipes = try Recipe.getRecipeData(data: recipeData)
        recipeArray = recipes ?? []
      } catch {
        XCTFail("\(error)")
      }
      // Assert
      XCTAssertTrue(recipeArray.count == 10, "Was expecting 10 events, but found \(recipeArray.count)")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
