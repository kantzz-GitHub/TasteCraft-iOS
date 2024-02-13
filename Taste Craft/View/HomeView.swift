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
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    Button("Logout") {
                        do {
                            let firebaseAuth = Auth.auth()
                            try firebaseAuth.signOut()
                            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                            UserDefaults.standard.synchronize()
                            
                            
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let navController = mainStoryboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
                            UIApplication.shared.windows.first?.rootViewController = navController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()

                        } catch {
                            print("Failed with error: \(error.localizedDescription)")
                        }
                    }
                }
            }
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
