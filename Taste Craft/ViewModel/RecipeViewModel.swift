//
//  RecipeViewModel.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    @Published var selectedRecipe: RecipeDetails? = nil
    
    var recipeFetcher: RecipeFetching = RecipeFetcher()
    
    func getRecipeInstructions(for mealId: String) async {
        do {
            let response = try await recipeFetcher.loadRecipe(for: mealId)
            
            if let meal = response.meals.first {
                let recipe = RecipeDetails(meal: meal as [String : Any])
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.selectedRecipe = recipe
                }
            }
        } catch {
            debugPrint("Failed with error: \(error.localizedDescription)")
        }
    }
}
