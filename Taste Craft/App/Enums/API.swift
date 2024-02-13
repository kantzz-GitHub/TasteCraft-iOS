//
//  API.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-11.
//

import Foundation

enum MealDB {
    case categories
    case filteredCategory(category: String)
}

extension MealDB: NetworkRequestable {
    
    var host: String {
        "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/json/v1/1/categories.php"
        case .filteredCategory:
            return "/api/json/v1/1/filter.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .categories, .filteredCategory:
            return .get
        }
    }
    
    var queryParameters: [String : AnyHashable]? {
        switch self {
        case .categories:
            return nil
        case .filteredCategory(let category):
            return ["c": category]
        }
    }
}
