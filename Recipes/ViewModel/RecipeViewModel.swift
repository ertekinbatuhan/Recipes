//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 26.08.2024.
//

import Foundation

class RecipeViewModel {
    
    private let recipeService: RecipeService
    private var currentOffset = 0
    private var totalResults = 0
    private var isFetching = false
    private let pageSize = 10
    
    weak var delegate: RecipeViewModelDelegate?
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
    func fetchRecipes(query: String) {
        guard !isFetching else { return }
        isFetching = true
        recipeService.searchRecipes(query: query, offset: currentOffset, number: pageSize) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeResponse):
                    self.totalResults = recipeResponse.totalResults
                    self.currentOffset += self.pageSize
                    self.delegate?.updateRecipeListView(with: recipeResponse.results)
                    print(recipeResponse.results)
                case .failure(let error):
                    self.delegate?.updateRecipeListView(with: [])
                    print("Error fetching recipes: \(error)")
                }
            }
        }
    }
    
    func loadMoreRecipes(query: String) {
        guard currentOffset < totalResults else { return } 
        fetchRecipes(query: query)
    }
}
