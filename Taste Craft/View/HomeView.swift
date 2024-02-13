//
//  HomeView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.categories) { category in
                        NavigationLink(destination: MealsView(category: category.name)) {
                            CategoryView(name: category.name, imageURL: category.thumbnail)
                                .padding(6)
                        }
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
            }.navigationTitle("Categories")
        }.onAppear {
            Task {
                await viewModel.getListOfAvailableCategories()
            }
        }
    }
    
    private func getAllCategories() {
        Task {
            await viewModel.getListOfAvailableCategories()
        }
    }
}

#Preview {
    HomeView()
}
