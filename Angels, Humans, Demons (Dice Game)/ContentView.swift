//
//  ContentView.swift
//  Angels, Humans, Demons (Dice Game)
//
//  Created by Betzy Moreno on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var playerOneTurn = true
    @State private var playerOneScore = 0
    @State private var playerTwoScore = 0
    @State private var numberOfTurns = 1
    @State private var randomValue = [0, 0, 0]
    @State private var rotation = 0.0
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        NavigationView() {
            ZStack {
                Color.brown.opacity(0.7).ignoresSafeArea()
                VStack {
                    Image("Logo").resizable().frame(width: 260, height: 200)
                    CustomText(text: "Angels, Humans, Demons")
                    HStack {
                        Image("Demon Dice \(randomValue[0])")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding()
                        
                        Image("pips \(randomValue[1])")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding()
                        
                        Image("Angel Dice \(randomValue[2])")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding()
                    }
                    CustomText(text: playerOneTurn ? "Player One Turn" : "Player Two Turn")
                    CustomText(text: "Turn Number: \(numberOfTurns)")
                    Button("Roll") {
                        chooseRandom(times: 3)
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotation += 360
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    CustomText(text: "player One: \(playerOneScore)")
                    CustomText(text: "player Two: \(playerTwoScore)")
                    NavigationLink("How to play", destination: InstructionsView())
                        .font(Font.custom("MetalMania-Regular", size: 24))
                        .padding()
                    Spacer()
                }
                //.font(.custom("block_out", size: 26))
            }
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .destructive(Text("Play again"),
                action: {
                resetGame()
            }))
        }
    }
    
    func chooseRandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline:  .now() + 1) {
                randomValue[0] = Int.random(in: 1...6)
                randomValue[1] = Int.random(in: 1...6)
                randomValue[2] = Int.random(in: 1...6)
                chooseRandom(times: times - 1)
            }
        }
        else {
            let rollTotal = randomValue[0] + randomValue[1] + randomValue[2]
            if playerOneTurn {
                playerOneScore += rollTotal
            }
            else {
                playerTwoScore += rollTotal
                numberOfTurns += 1
            }
            if playerOneScore >= 130 {
                winMessage = "Player One is an Angel"
                gameOver = true
            }
            else if playerTwoScore >= 130 {
                winMessage = "Player Two is an Angel"
                gameOver = true
            }
            else if numberOfTurns > 10 {
                if playerOneScore > playerTwoScore {
                    winMessage = "Player One is a Human\nPlayer Two is a Demon"
                    gameOver = true
                }
                if playerOneScore < playerTwoScore {
                    winMessage = "Player One is a Demon\nPlayer Two is a Human"
                    gameOver = true
                }
                else {
                    winMessage = "Player One is a Human\nPlayer Two is a Human"
                    gameOver = true
                }
            }
            else {
                playerOneTurn.toggle()
            }
        }
    }
    
    func resetGame() {
        playerOneScore = 0
        playerTwoScore = 0
        numberOfTurns = 0
        gameOver = false
    }
}

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("MetalMania-Regular", size: 36))
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50)
            .font(Font.custom("MetalMania-Regular", size: 24))
            .padding()
            .background(.black).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct InstructionsView: View {
    var body: some View {
        ZStack {
            Color.brown.opacity(0.7).ignoresSafeArea()
            VStack{
                Text("Angels, Humans, Demons").font(.title)
                VStack {
                    Text("Angels, Humans, Demons game is a perfect game to pass on the time with a friend, or to play for fun. Both players have the limit of 20 turns by pressing the \"Roll\".")
                        .padding()
                        .padding()
                    Text("If a player gets a 130 points, they atomaticly win for the angel side.")
                        .padding()
                    Text("As for someone who has more points then the other player, they will be consider a human while the player with the least points will be a demon.")
                        .padding()
                    Text("In the case that both players are in the human side when they use up their turns, it will be a Tie, thus restart the game.")
                        .padding()
                    Text("Well, make sure to read the basics and have fun on playing the game, no fowl mouth and no sore loosers, and if your thinking of kicking the other guy in the weak spot, Don't please.")
                        .padding()
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
