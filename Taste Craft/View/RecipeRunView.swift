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
    @State var hideBack: Bool = true
    @State var hideDone: Bool = true
    
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
            
            HStack{
                
                Button {
                    count -= 1
                    self.hideBack = false
                    self.hideNext = false
                    self.hideDone = true
                    
                    if(count == 0){
                        self.hideBack = true
                        self.hideNext = false
                    }
                } label: {
                    Text("BACK")
                        .padding()
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                .disabled(hideBack)
                
                
                Button {
                    count += 1
                    self.hideNext = false
                    self.hideBack = false
                    
                    if(count == recipeRunViewModel.instructionsArray.count - 1){
                        self.hideDone = false
                        self.hideNext = true
                    }
                } label: {
                    Text("NEXT")
                        .padding()
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                .disabled(hideNext)
                
                
                Button {
                    if(count == recipeRunViewModel.instructionsArray.count - 1){
                        self.hideDone = false
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.hideDone = true
                    }
                } label: {
                    Text("DONE")
                        .padding()
                        .font(.title)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                .disabled(hideDone)
            }
        }
        .onAppear{
            Task{
                
            }
        }
    }
}

#Preview {
    RecipeRunView()
}
