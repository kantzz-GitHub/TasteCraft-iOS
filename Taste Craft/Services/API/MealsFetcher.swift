//
//  MealsFetcher.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

protocol MealsFetching {
    func loadMeals(for category: String) async throws -> Meals
}

struct MealsFetcher: MealsFetching {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadMeals(for category: String) async throws -> Meals {
        let request = try MealDB.filteredCategory(category: category).createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        try validateHTTPResponse(urlResponse: response)
        
        return try JSONDecoder().decode(Meals.self, from: data)
    }
    
    private func validateHTTPResponse(urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              let mimeType = httpResponse.mimeType,
              mimeType.contains("json") else {
            throw URLError(.badServerResponse)
        }
    }
}
