//
//  RecipeUnitTests.swift
//  RecipeUnitTests
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import XCTest
@testable import Recipes

final class RecipeUnitTests: XCTestCase {
    
    private var recipeViewModel: RecipeViewModel!
    private var recipeService: MockRecipeService!
    private var mockDelegate: MockRecipeViewModelDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        recipeService = MockRecipeService()
        recipeViewModel = RecipeViewModel(recipeService: recipeService)
        mockDelegate = MockRecipeViewModelDelegate()
        recipeViewModel.delegate = mockDelegate
    }
    
    override func tearDownWithError() throws {
        recipeViewModel = nil
        recipeService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testUpdateRecipeView_whenAPISuccess_showsRecipeTitle() throws {
        // Given
        let expectedRecipe = RecipeResult(id: 1, title: "Test Recipe", image: "test_image.jpg", imageType: .jpg)
        let recipeResponse = Recipe(results: [expectedRecipe], offset: 0, number: 1, totalResults: 1)
        recipeService.fetchRecipeMockResult = .success(recipeResponse)
        
        let expectation = self.expectation(description: "Recipe list updated with success")
        
        // When
        recipeViewModel.fetchRecipes(query: "test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            XCTAssertEqual(self.mockDelegate.recipes.count, 1)
            XCTAssertEqual(self.mockDelegate.recipes.first?.title, "Test Recipe")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testUpdateRecipeView_whenAPIFailure_showsNoRecipeTitle() throws {
        // Given
        recipeService.fetchRecipeMockResult = .failure(.invalidURL)
        
        let expectation = self.expectation(description: "Recipe list updated with error")
        
        // When
        recipeViewModel.fetchRecipes(query: "test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            XCTAssertTrue(self.mockDelegate.recipes.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
