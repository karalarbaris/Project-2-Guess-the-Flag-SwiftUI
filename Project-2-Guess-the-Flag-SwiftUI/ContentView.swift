//
//  ContentView.swift
//  Project-2-Guess-the-Flag-SwiftUI
//
//  Created by Baris Karalar on 7.06.2021.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2, x: 0, y: 0)
        
    }
}

extension View {
    func flagImage() -> some View {
        self.modifier(FlagImage())
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",
                                    "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var animationAmountForButtons = [0.0, 0.0, 0.0]
    @State private var opacityAmountForButtons = [1.0, 1.0, 1.0]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing:30) {
                    
                    VStack(spacing:10) {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text("\(countries[correctAnswer])")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.largeTitle)
                    }
                    
//                    Button(action: {
//                        //Button was tapped
//                        flagTapped(0)
//
//                    }, label: {
//                        Image(countries[0])
//                            .renderingMode(.original)
//                    })
//                    .flagImage()
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            //Button was tapped
                            flagTapped(number)
                            
                            
                        }, label: {
                            Image(countries[number])
                                .renderingMode(.original)
                        })
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2, x: 0, y: 0)
                        .rotation3DEffect(
                            .degrees(animationAmountForButtons[number]),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .opacity(opacityAmountForButtons[number])
                    }
                    
                    Text("Current score is \(userScore)")
                    
                    Spacer()
                }
            }
            .alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Countinue"), action: {
                    askQuestion()
                }))
            })
        }
        
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            withAnimation {
                animationAmountForButtons[number] += 360
                opacityAmountForButtons = [0.25, 0.25, 0.25]
                opacityAmountForButtons[number] = 1
            }
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            userScore -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmountForButtons = [1.0, 1.0, 1.0]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
