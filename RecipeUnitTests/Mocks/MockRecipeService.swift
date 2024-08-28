//
//  MockRecipeService.swift
//  RecipeUnitTests
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import XCTest
@testable import Recipes

class MockRecipeService: RecipeService {
    var fetchRecipeMockResult: Result<Recipe, RecipeError>?
    
    func searchRecipes(query: String, offset: Int, number: Int, completion: @escaping (Result<Recipe, RecipeError>) -> Void) {
        if let result = fetchRecipeMockResult {
            completion(result)
        }
    }
}
