//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by Paul Krznaric on 2020-06-09.
//  Copyright © 2020 Krznarnetic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var instructionText = ""
    
    @State private var shouldWin = Bool.random()
    @State private var currentMove = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var scoreText = ""
    @State private var continueText = ""
    @State private var roundCounter = 0
    
    @State private var showContinueAlert = false
    @State private var showEndGameAlert = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                                          startPoint: .top, endPoint: .bottom)
                               .edgesIgnoringSafeArea(.all)
                VStack{
                    if(shouldWin){
                        Text("Your goal this round is to win.")
                        .foregroundColor(.white)
                    }
                    else{
                        Text("Your goal this round is to lose")
                        .foregroundColor(.white)
                    }
                    
                    
                    Text("Computer selects: \(moves[currentMove])")
                        .foregroundColor(.white)
                    ForEach(0..<3){ number in
                        Button(action: {
                            self.answerTapped(answer: number)
                        }){
                            Text(self.moves[number])
                        }
                    }
                    
                    Text("Your current score is: \(score)")
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        .alert(isPresented: $showContinueAlert) {
            Alert(title: Text(scoreTitle), message:
            Text("\(scoreText)"),
                  dismissButton:
                .default(Text("\(continueText)")){
                    self.continueGame()
                })
            }
        }
    }
    
    func answerTapped(answer: Int)
    {
        let correctAnswer = getCorrectAnswer(computerMove: currentMove)
        if(answer == correctAnswer)
        {
            score += 1
            scoreTitle = "Correct"
        }
        else
        {
            score -= 1
            scoreTitle = "Incorrect. The correct answer was: \(moves[correctAnswer])"
        }
        
        if(roundCounter < 10)
        {
            scoreText = "Your score is \(score)"
            continueText = "Continue"
        }
        else{
            scoreText = "Your final score is \(score)"
            continueText = "New Game?"
        }
        showContinueAlert = true
    }
    
    func checkWinText(){
        if(shouldWin){
            
        }
    }
    
    func getCorrectAnswer(computerMove: Int) -> Int{
        if(shouldWin){
            return abs((computerMove - 2) % 3)
        }
        return (computerMove + 2) % 3

    }
    
    
    
    func continueGame()
    {
        roundCounter += 1
        if(roundCounter >= 10)
        {
            roundCounter = 0
            score = 0
        }
        shouldWin = Bool.random()
        currentMove = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
