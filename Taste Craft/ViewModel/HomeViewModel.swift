//
//  HomeViewModel.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var categories: [Category] = []
    @Published var meals: Meals? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    var fetcher: CategoriesFetching = CategoriesFetcher()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                if !text.isEmpty {
                    Task {
                        await self.getListOfMeals(for: text)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
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
    
    func getListOfMeals(for ingredient: String) async {
        do {
            let response = try await fetcher.loadMeal(for: ingredient)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.meals = response
            }
        } catch {
            debugPrint("Failed with error: \(error.localizedDescription)")
        }
    }
}
