//
//  HomeView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                VStack {
                    List {
                        if viewModel.searchText.isEmpty {
                            ForEach(viewModel.categories) { category in
                                NavigationLink(destination: MealsView(category: category.name)) {
                                    CategoryView(name: category.name, imageURL: category.thumbnail)
                                        .padding(6)
                                }
                            }.listRowSeparator(.hidden)
                        } else {
                            if let mealResponse = viewModel.meals {
                                ForEach(mealResponse.meals) { meal in
                                    NavigationLink(destination: RecipeView(mealID: meal.id, meal: meal)) {
                                        MealCardView(name: meal.name, imageURL: meal.thumbnail)
                                    }
                                }.listRowSeparator(.hidden)
                            } else {
                                ContentUnavailableView(
                                    "No Results for \(viewModel.searchText)",
                                    systemImage: "carrot"
                                )
                                .listRowSeparator(.hidden)
                            }
                        }
                    }.listStyle(.plain)
                }
                .tabItem {
                    Label("Meals", systemImage: "takeoutbag.and.cup.and.straw")
                }.tag(0)
                
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "gobackward")
                    }
                    .tag(1)
            }
            .searchable(text: $viewModel.searchText)
            .navigationBarTitle(selectedTab == 1 ? "History" : "Categories")
            .toolbar {
                ToolbarItem {
                    Button("Logout") {
                        defer { moveToLoginView() }
                        do {
                            let firebaseAuth = Auth.auth()
                            try firebaseAuth.signOut()
                            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                            UserDefaults.standard.synchronize()
                        } catch {
                            print("Failed with error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .onAppear {
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
    
    private func searchMeal(for ingredient: String) {
        Task {
            await viewModel.getListOfMeals(for: ingredient)
        }
    }
    
    private func moveToLoginView() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

#Preview {
    HomeView()
}
