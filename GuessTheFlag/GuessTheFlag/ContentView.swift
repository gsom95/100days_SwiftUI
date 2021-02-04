//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Igor on 25.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    @State private var animationAmount = 0.0
    @State private var wrongAnswersOpacity = 1.0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }

                ForEach(0 ..< 3) { index in
                    Button(action: {
                        flagTapped(index)
                    }, label: {
                        if index == correctAnswer {
                            Image(countries[index])
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .rotationEffect(.degrees(animationAmount))
                                .animation(Animation.easeInOut(duration: 1.0))
                        } else {
                            Image(countries[index])
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .opacity(self.wrongAnswersOpacity)
                        }
                    })
                }

                Text("Current score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()

                Spacer()
            }
        }
        .actionSheet(isPresented: $showingScore) {
            ActionSheet(title: Text(scoreTitle), message: Text("Your score is \(score)"), buttons: [
                .default(Text("Continue")) {
                    self.wrongAnswersOpacity = 1.0
                    self.askQuestion()
                },
            ])
        }
    }

    func flagTapped(_ number: Int) {
        wrongAnswersOpacity = 0.25
        if number == correctAnswer {
            // Although we have 64bit ints, I don't want to risk and wait for int overflow. Thus this check.
            if animationAmount > 360 {
                animationAmount -= 360
            } else {
                animationAmount += 360
            }

            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong\nIt's the flag of \(countries[number])"
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
