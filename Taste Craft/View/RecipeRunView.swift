//
//  RecipeRunView.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-03-03.
//

import SwiftUI

struct RecipeRunView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var recipeRunViewModel = RecipeRunViewModel()
    @State var count: Int = 0
    @State var hideNext: Bool = false
    @State var hideGoBack: Bool = true
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text(recipeRunViewModel.instructionsArray[count])
                    .font(.title)
                    .padding()
                    .navigationBarBackButtonHidden(true)
            }
            
            Spacer()
            
            VStack{
        
                Button("Go Back") {
                    if count == 0{
                        self.hideGoBack = true
                        self.hideNext = false
                    } else {
                        count -= 1
                        self.hideGoBack = false
                        self.hideNext = false
                    }
                }
                .font(.title)
                .disabled(hideGoBack)
//                .padding()
                
                Button("Next"){
                    if(count < recipeRunViewModel.instructionsArray.count - 1){
                        count += 1
                        self.hideNext = false
                        self.hideGoBack = false
                    } else {
                        self.hideNext = true
                        self.hideGoBack = false
                    }
                }
                .font(.title)
                .disabled(hideNext)
                .padding()
            }
            .padding()
        }.onAppear{
            Task{
                
            }
        }
    }
}

#Preview {
    RecipeRunView()
}
