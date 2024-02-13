//
//  CategoryView.swift
//  Taste Craft
//
//  Created by Vishweshwaran on 2024-02-12.
//

import Foundation
import SwiftUI

struct CategoryView: View {
    
    let name: String
    let imageURL: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)!)
                .padding()
            ZStack {
                Color.black.opacity(0.5)
                Text(name)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
            }
            .frame(maxHeight: 50)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 2)
    }
}
