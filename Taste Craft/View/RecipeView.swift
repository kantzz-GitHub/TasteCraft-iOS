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
    private let userDefaultsKey = "recipeRunCountKey"
    @State private var recipeRunCount: Int = 0
    
    var mealID: String
    var meal: Meal
    
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
                            }
                        }
                        .padding()
                        
                        VStack{
                            NavigationLink(destination: RecipeRunView(recipeRunViewModel: recipeRunViewModel).onAppear {
                                recipeRunCount += 1
                                print(recipeRunCount)
                                UserDefaults.standard.set(recipeRunCount, forKey: userDefaultsKey)
                            }){
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
                    let retrievedValue = UserDefaults.standard.integer(forKey: userDefaultsKey)
                    
                    recipeRunCount = retrievedValue
                    
                    print(recipeRunCount)
                                    
                    
                    await viewModel.getRecipeInstructions(for: mealID)
                    if let instructions = viewModel.selectedRecipe?.strInstructions {
                        recipeRunViewModel.selectedMeal = meal
                        recipeRunViewModel.instructionsArray = instructions.components(separatedBy: "\r\n")
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}
