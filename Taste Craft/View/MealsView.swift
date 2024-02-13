//
//  MealsView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import SwiftUI

struct MealsView: View {
    
    @StateObject var viewModel = MealViewModel()
    
    var category: String
    
    init(category: String) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            VStack {
                List {
                    ForEach(viewModel.meals) { meal in
                        MealCardView(name: meal.name, imageURL: meal.thumbnail)
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
            }
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadListOfMeals(for: category)
            }
        }
    }
}

#Preview {
    MealsView(category: "Beef")
}
