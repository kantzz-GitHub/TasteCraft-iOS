//
//  RecipeViewModel.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    @Published var selectedRecipe: RecipeDetails? = nil
    @Published var recipe: Recipe? = nil
    
    var navigationTitle: String = ""
    var recipeFetcher: RecipeFetching = RecipeFetcher()
    
    func getRecipeInstructions(for mealId: String) async {
        do {
            let response = try await recipeFetcher.loadRecipe(for: mealId)
            self.recipe = response
            
            if let meal = response.meals.first {
                let recipe = RecipeDetails(meal: meal as [String : Any])
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.selectedRecipe = recipe
                    navigationTitle = selectedRecipe?.strMeal ?? ""
                }
            }
        } catch {
            debugPrint("Failed with error: \(error.localizedDescription)")
        }
    }
}
