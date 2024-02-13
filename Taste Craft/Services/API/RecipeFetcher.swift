//
//  RecipeFetcher.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

protocol RecipeFetching {
    func loadRecipe(for mealID: String) async throws -> Recipe
}

struct RecipeFetcher: RecipeFetching {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadRecipe(for mealID: String) async throws -> Recipe {
        let request = try MealDB.detailRecipe(mealID: mealID).createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        try validateHTTPResponse(urlResponse: response)
        
        return try JSONDecoder().decode(Recipe.self, from: data)
    }
    
    private func validateHTTPResponse(urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              let mimeType = httpResponse.mimeType,
              mimeType.contains("json") else {
            throw URLError(.badServerResponse)
        }
    }
}
