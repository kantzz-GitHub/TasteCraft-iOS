//
//  API.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-11.
//

import Foundation

enum MealDB {
    case categories
    case search(ingredient: String)
    case filteredCategory(category: String)
    case detailRecipe(mealID: String)
}

extension MealDB: NetworkRequestable {
    
    var host: String {
        "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/json/v1/1/categories.php"
        case .search:
            return "/api/json/v1/1/search.php"
        case .filteredCategory:
            return "/api/json/v1/1/filter.php"
        case .detailRecipe:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .categories, .search, .filteredCategory, .detailRecipe:
            return .get
        }
    }
    
    var queryParameters: [String : AnyHashable]? {
        switch self {
        case .categories:
            return nil
        case .search(let ingredient):
            return ["s": ingredient]
        case .filteredCategory(let category):
            return ["c": category]
        case .detailRecipe(let mealID):
            return ["i": mealID]
        }
    }
}
