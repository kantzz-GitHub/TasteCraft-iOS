//
//  SavedViewModel.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-04-09.
//

import Foundation

@Observable
final class SavedViewModel {
    
    var meals: [Meal] = []
    
    func addItemsToUserDefaults(meal: Meal) {
        loadMealsFromUserDefaults()
        
        if !meals.contains(where: { $0.id == meal.id }) {
            meals.append(meal)
            
            saveMealsToUserDefaults()
        }
    }
    
    func saveMealsToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(meals)
            
            UserDefaults.standard.set(data, forKey: "savedRecipes")
        } catch {
            print("Error encoding meals: \(error.localizedDescription)")
        }
    }
    
    func loadMealsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "savedRecipes") {
            do {
                let decoder = JSONDecoder()
                let loadedMeals = try decoder.decode([Meal].self, from: data)
                
                let uniqueLoadedMeals = loadedMeals.filter { loadedMeal in
                    !meals.contains(where: { $0.id == loadedMeal.id })
                }
                
                meals.append(contentsOf: uniqueLoadedMeals)
            } catch {
                print("Error decoding meals: \(error.localizedDescription)")
            }
        }
    }
}
