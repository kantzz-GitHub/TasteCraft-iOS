//
//  SavedView.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-04-09.
//

import SwiftUI

import SwiftUI

struct SavedView: View {
    
    @State var viewModel = SavedViewModel()
    
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
    SavedView()
}
