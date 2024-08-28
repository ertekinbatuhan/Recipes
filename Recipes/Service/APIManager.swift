//
//  RecipeService.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 26.08.2024.
//

import Foundation

class APIManager: RecipeService {
    
    private func getAPIURL(query: String, offset: Int, number: Int) -> URL? {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "apiKey", value: APIConstants.apiKey),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "number", value: String(number))
        ]
        return urlComponents?.url
    }
    
    func searchRecipes(query: String, offset: Int, number: Int, completion: @escaping (Swift.Result<Recipe, RecipeError>) -> Void) {
        guard let url = getAPIURL(query: query, offset: offset, number: number) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.httpError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Recipe.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
