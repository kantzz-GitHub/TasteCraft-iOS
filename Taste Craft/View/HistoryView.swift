//
//  HistoryView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-04-08.
//

import SwiftUI

struct HistoryView: View {
    
    @State var viewModel = HistoryViewModel()
    
    var body: some View {
        VStack {
            VStack {
                List {
                    ForEach(viewModel.meals) { meal in
                        NavigationLink(destination: RecipeView(mealID: meal.id, meal: meal)) {
                            MealCardView(name: meal.name, imageURL: meal.thumbnail)
                        }
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.loadMealsFromUserDefaults()
        }
    }
}

#Preview {
    HistoryView()
}
