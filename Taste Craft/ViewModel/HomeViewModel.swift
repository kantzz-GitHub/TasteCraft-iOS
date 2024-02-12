//
//  HomeViewModel.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    var fetcher: CategoriesFetching = CategoriesFetcher()
    
    func getListOfAvailableCategories() async {
        do {
            let response = try await fetcher.loadFoodCategories()
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.categories = response.categories
            }
        } catch {
            debugPrint("Failed with error: \(error.localizedDescription)")
        }
    }
}
