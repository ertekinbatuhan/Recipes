//
//  RecipeService.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 27.08.2024.
//

import Foundation

protocol RecipeService {
    func searchRecipes(query: String, offset: Int, number: Int, completion: @escaping (Swift.Result<Recipe, RecipeError>) -> Void)
}
