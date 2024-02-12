//
//  API.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-11.
//

import Foundation

enum MealDB {
    case categories
}

extension MealDB: NetworkRequestable {
    
    var host: String {
        "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/json/v1/1/categories.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .categories:
            return .get
        }
    }
    
    var queryParameters: [String : AnyHashable]? {
        return nil
    }
}
