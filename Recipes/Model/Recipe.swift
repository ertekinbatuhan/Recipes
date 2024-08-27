//
//  Recipe.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 26.08.2024.
//

import Foundation

//MARK: - Recipe
struct Recipe: Codable {
    let results: [RecipeResult]
    let offset, number, totalResults: Int
}

// MARK: - RecipeResult
struct RecipeResult: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}


