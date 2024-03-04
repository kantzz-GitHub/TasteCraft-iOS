//
//  RecipeView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import SwiftUI

struct RecipeView: View {
    
    @StateObject var viewModel = RecipeViewModel()
    @State var recipeRunViewModel = RecipeRunViewModel()
    
    var mealID: String
    
    var body: some View {
        NavigationView{
            VStack {
                if let recipe = viewModel.selectedRecipe {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Meal: \(recipe.strMeal ?? "")")
                                .font(.title)
                            Text("Category: \(recipe.strCategory ?? "")")
                                .font(.headline)
                            
                            if let ingredients = recipe.ingredientsAndMeasurements {
                                Text("Ingredients:")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                ForEach(ingredients) { ingredient in
                                    Text("\(ingredient.name): \(ingredient.measurement)")
                                        .font(.body)
                                }
                            }
                            
                            if let instructions = recipe.strInstructions {
                                
                                Text("Instructions:")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                Text(instructions)
                                    .font(.body)
                                //                            let _ = print(instructions)
                                //                            let myArray = instructions.components(separatedBy: "\r\n")
                                
                            }
                        }
                        .padding()
                        
                        VStack{
                            NavigationLink(destination: RecipeRunView(recipeRunViewModel: recipeRunViewModel)){
                                Text("RUN RECIPE!")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.blue, lineWidth: 1)
                                    )
                                
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }.onAppear {
                Task {
                    await viewModel.getRecipeInstructions(for: mealID)
                    if let instructions = viewModel.selectedRecipe?.strInstructions {
                        recipeRunViewModel.instructionsArray = instructions.components(separatedBy: "\r\n")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeView(mealID: "52772")
}
