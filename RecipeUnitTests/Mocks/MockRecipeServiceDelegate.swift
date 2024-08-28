//
//  MockRecipeServiceDelegate.swift
//  RecipeUnitTests
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import XCTest
@testable import Recipes


class MockRecipeViewModelDelegate: RecipeViewModelDelegate {
    var recipes: [RecipeResult] = []
    
    func updateRecipeListView(with recipes: [RecipeResult]) {
        self.recipes = recipes
    }
}
