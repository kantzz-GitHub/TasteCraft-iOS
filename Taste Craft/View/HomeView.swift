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
        ZStack {
            Text("Hello, World!")
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
