//
//  RankView.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-04-09.
//

import SwiftUI

class RankViewModel: ObservableObject {
    @Published var recipeCount: Int
    
    init() {
        // Initialize recipeCount with UserDefaults value
        recipeCount = UserDefaults.standard.integer(forKey: "recipeRunCountKey")
        
        // Listen for UserDefaults changes
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc private func userDefaultsDidChange() {
        // Update recipeCount when UserDefaults changes
        recipeCount = UserDefaults.standard.integer(forKey: "recipeRunCountKey")
    }
    
    func getRank(for num: Int) -> String {
        switch num {
        case 0...5:
            return "Novice"
        case 6...10:
            return "Beginner"
        case 11...30:
            return "Momma's Chef"
        case 31...60:
            return "That guy who cooks"
        case 61...80:
            return "Professional"
        case 81...120:
            return "Gordon Freaking Ramsay"
        default:
            return "Legend"
        }
    }
}

struct RankView: View {
    @StateObject private var viewModel = RankViewModel()
    
    var body: some View {
        VStack {
            Text("You have run \(viewModel.recipeCount) recipes")
                .fontWeight(.bold)
                .font(.title)
            Spacer()
            Image(viewModel.getRank(for: viewModel.recipeCount))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
//                .padding()
            Spacer()
            Text("Your current rank is: ")
                .font(.title)
            Text("\(viewModel.getRank(for: viewModel.recipeCount))")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
