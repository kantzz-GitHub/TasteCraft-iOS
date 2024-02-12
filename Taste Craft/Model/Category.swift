//
//  Category.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

struct Categories: Decodable {
    let categories: [Category]
}

struct Category: Decodable, Identifiable {
    
    var id: UUID = UUID()
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
    }
}
