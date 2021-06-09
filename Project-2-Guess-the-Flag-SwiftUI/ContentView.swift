//
//  ContentView.swift
//  Project-2-Guess-the-Flag-SwiftUI
//
//  Created by Baris Karalar on 7.06.2021.
//

import SwiftUI

//Showing alert messages

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",
                     "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack {
            
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing:30) {
                
                VStack(spacing:10) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        //Button was tapped
                        flagTapped(number)
                        
                    }, label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    })
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Countinue"), action: {
                askQuestion()
            }))
        })
        
        
        
        
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            print("correct")
        } else {
            scoreTitle = "False"
            print("false")
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
