//
//  MealCardView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import SwiftUI

struct MealCardView: View {
    
    let name: String
    let imageURL: String
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: imageURL)!) { image in
                    image
                        .resizable()
                        .frame(maxHeight: 300)
                } placeholder: {
                    ProgressView()
                        .padding()
                }
                Text(name)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 6)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 2)
    }
}

#Preview {
    MealCardView(name: "Beef", imageURL: "https:www.themealdb.com/images/media/meals/sbx7n71587673021.jpg")
}
