//
//  RecipeError.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 26.08.2024.
//

import Foundation

enum RecipeError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    case httpError(statusCode: Int)
}
