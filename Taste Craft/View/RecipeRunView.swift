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
    
    @State private var isClockButtonVisible: Bool = false
    @State private var showingAlert: Bool = false
    
    private let searchFor = ["minutes", "hour"]
    
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
                if isClockButtonVisible{
                    Button("TIMER!") {
                        showingAlert = true
                    }
                    .padding()
                    .font(.title)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1)
                    )
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Timer!"),
                            message: Text("Open the Clock App and set the timer xD"),
                            primaryButton: .default(Text("OK")),
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            
            
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
                    displayAlarmButton()
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
    func displayAlarmButton(){
        var currentInstruction = recipeRunViewModel.instructionsArray[count]
        
        isClockButtonVisible = false
        
        for i in searchFor{
            if currentInstruction.contains(i){
                isClockButtonVisible = true
                print(i)
                break
            }
        }
    }
}

#Preview {
    RecipeRunView()
}
