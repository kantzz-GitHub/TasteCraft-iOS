//
//  MealViewModel.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

final class MealViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    
    var mealsFetcher: MealsFetcher = MealsFetcher()
    
    func loadListOfMeals(for category: String) async {
        do {
            let response = try await mealsFetcher.loadMeals(for: category)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.meals = response.meals
            }
        } catch {
            debugPrint("Failed with error: \(error.localizedDescription)")
        }
    }
}
