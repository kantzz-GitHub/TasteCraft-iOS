//
//  CategoriesFetcher.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

protocol CategoriesFetching {
    func loadFoodCategories() async throws -> Categories
    func loadMeal(for ingredient: String) async throws -> Meals
}

struct CategoriesFetcher: CategoriesFetching {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadFoodCategories() async throws -> Categories {
        let request = try MealDB.categories.createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        try validateHTTPResponse(urlResponse: response)
        
        return try JSONDecoder().decode(Categories.self, from: data)
    }
    
    func loadMeal(for ingredient: String) async throws -> Meals {
        let request = try MealDB.search(ingredient: ingredient).createRequest()
        
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

