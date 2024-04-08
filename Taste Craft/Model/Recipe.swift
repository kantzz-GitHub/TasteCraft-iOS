//
//  Recipe.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

struct Recipe: Codable {
    let meals: [[String: String?]]
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let measurement: String
}


struct RecipeDetails {
    
    let meal: [String: Any]
    
    var strMeal: String? {
        meal["strMeal"] as? String
    }
    
    var strCategory: String? {
        meal["strCategory"] as? String
    }
    
    var strInstructions: String? {
        meal["strInstructions"] as? String
    }
    
    var ingredientsAndMeasurements: [Ingredient]? {
        var ingredientsAndMeasurements: [Ingredient] = []
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measurementKey = "strMeasure\(i)"
            if let ingredient = meal[ingredientKey] as? String,
               let measurement = meal[measurementKey] as? String,
               !ingredient.isEmpty && !measurement.isEmpty {
                ingredientsAndMeasurements.append(Ingredient(name: ingredient, measurement: measurement))
            }
        }
        return ingredientsAndMeasurements
    }
}
