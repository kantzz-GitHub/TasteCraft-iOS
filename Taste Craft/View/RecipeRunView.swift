//
//  RecipeRunView.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-03-03.
//

import SwiftUI

struct RecipeRunView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var recipeRunViewModel: RecipeRunViewModel
    @State var count: Int = 0
    @State var hideNext: Bool = false
    @State var hideBack: Bool = true
    @State var hideDone: Bool = true
    
    @State private var isClockButtonVisible: Bool = false
    @State private var showingAlert: Bool = false
    
    private let searchFor = ["minutes", "hour"]
    
    @State private var countdownTimerText: String = ""
    @State private var duration: Int?
    @State private var unit: String?
    
    @State private var timer: Timer?
    
    init(recipeRunViewModel: RecipeRunViewModel) {
        self._recipeRunViewModel = State(initialValue: recipeRunViewModel)
        let viewModel = HistoryViewModel()
        if let selectedMeal = recipeRunViewModel.selectedMeal {
            viewModel.addItemsToUserDefaults(meal: selectedMeal)
        }
    }
    
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
                    Text("\(countdownTimerText)")
                        .bold()
                    Button("TIMER!") {
                        startTimer()
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
                    displayAlarmButton()
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
    
    func displayAlarmButton() {
        let currentInstruction = recipeRunViewModel.instructionsArray[count]
        let regex = try! NSRegularExpression(pattern: #"\b((\d{1,2})|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve))\s*(hours?|minutes?)\b"#)
        let matches = regex.matches(in: currentInstruction, range: NSRange(currentInstruction.startIndex..., in: currentInstruction))
        
        for match in matches {
            if let range = Range(match.range, in: currentInstruction) {
                let matchedText = currentInstruction[range]
                
                let components = matchedText.components(separatedBy: .whitespaces)
                var duration: Int = 0
                var unit: String = ""
                
                if components.count == 2 {
                    if let number = Int(components[0]) {
                        duration = number
                        unit = components[1]
                    } else {
                        switch components[0] {
                        case "one":
                            duration = 1
                        case "two":
                            duration = 2
                        case "three":
                            duration = 3
                        case "four":
                            duration = 4
                        case "five":
                            duration = 5
                        case "six":
                            duration = 6
                        case "seven":
                            duration = 7
                        case "eight":
                            duration = 8
                        case "nine":
                            duration = 9
                        case "ten":
                            duration = 10
                        case "eleven":
                            duration = 11
                        case "twelve":
                            duration = 12
                        default:
                            duration = 0
                        }
                        
                        unit = components[1]
                    }
                }
                
                self.duration = duration
                self.unit = unit
                
                countdownTimerText = "\(duration) \(unit)"
            }
        }
        
        isClockButtonVisible = !matches.isEmpty
    }
    
    func startTimer() {
        if let duration = duration, let unit = unit {
            var totalSeconds: Int = 0
            if unit == "hours" {
                totalSeconds = duration * 3600
            } else if unit == "minutes" {
                totalSeconds = duration * 60
            }
            
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                totalSeconds -= 1
                if totalSeconds <= 0 {
                    timer.invalidate()
                    countdownTimerText = "Timer expired!"
                } else {
                    let hours = totalSeconds / 3600
                    let minutes = (totalSeconds % 3600) / 60
                    let seconds = totalSeconds % 60
                    countdownTimerText = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                }
            }
        }
    }
}

#Preview {
    RecipeRunView(recipeRunViewModel: .init())
}
