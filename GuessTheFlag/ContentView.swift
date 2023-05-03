//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ivan Yarmoliuk on 4/27/23.
//

import SwiftUI

struct ContentView: View {
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Ukraine", "Italy", "Nigeria", "Poland", "Pidarrussia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAsswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var endGame = false
    @State private var score = 0
    @State private var tappedCountry = ""
    @State private var count = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the flag")
                    .titleStyle()
                VStack(spacing:30) {
                    
                    VStack {
                        Text("Tap to the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAsswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            
                            count += 1
                            if count >= 9 {
                                endGame = true
                            } else {
                                flagTapped(number: number)
                            }
                            
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
        }
        .alert("Game over!!!", isPresented: $endGame) {
            Button("Play again", role: .destructive, action: resetGame)
//            Button("Cencel", role: .destructive) {
//                //
//            }
        } message: {
            Text("Your final score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
            Button("Cencel", role: .cancel) {
               
            }
        } message: {
            if scoreTitle == "Wrong" {
                Text("This is flag of \(tappedCountry)")
            } else {
                Text("Your score is \(score)")
            }
            
            
        }
        
    }
    func flagTapped(number: Int) {
        tappedCountry = countries[number]
        print(tappedCountry)
        if number == correctAsswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAsswer = Int.random(in: 0...2)
    }
    func resetGame() {
        score = 0
        count = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
    
}
extension View {
    func titleStyle() -> some View {
        modifier(LargeBlue())
    }
}
