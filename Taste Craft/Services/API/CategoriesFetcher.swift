//
//  CategoriesFetcher.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

protocol CategoriesFetching {
    func loadFoodCategories() async throws -> Categories
}

struct CategoriesFetcher: CategoriesFetching {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadFoodCategories() async throws -> Categories {
        let request = try MealDB.categories.createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              let mimeType = httpResponse.mimeType,
              mimeType.contains("json") else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Categories.self, from: data)
    }
}

