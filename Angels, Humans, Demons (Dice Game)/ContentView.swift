//
//  ContentView.swift
//  Angels, Humans, Demons (Dice Game)
//
//  Created by Betzy Moreno on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var playerOne = 0
    @State private var playerTwo = 0
    @State private var randomValue = [0, 0, 0]
    @State private var rotation = 0.0
    var body: some View {
        NavigationView() {
            ZStack {
                Color.brown.opacity(0.7).ignoresSafeArea()
                VStack {
                    Image("Logo").resizable().frame(width: 260, height: 260)
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
                    Spacer()
                    CustomText(text: "player One: \(playerOne)")
                    HStack {
                        Button("Roll") {
                            chooseRandom(times: 3)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    CustomText(text: "player Two: \(playerTwo)")
                    NavigationLink("How to play", destination: InstructionsView())
                        .font(Font.custom("MetalMania-Regular", size: 24))
                        .padding()
                    Spacer()
                }
                //.font(.custom("block_out", size: 26))
            }
        }
    }
    func endTurn() {
        playerOne = 0
        playerTwo = 0
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
        if times == 0 {
            if randomValue[0] == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    endTurn()
                }
            }
            else {
                playerOne += playerTwo
            }
        }
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
                    Text("When someone gets three Snake eyes or something like a 5 or less, then you will get a deduction of 3 points off of there points.")
                        .padding()
                    Text("If a player gets a 130 points, they atomaticly win for the angel side, if your still in the 80s between the 100s, you will be in the human side.")
                        .padding()
                    Text("As for someone who gets a 80 or lower,they are below the 80s, they'll be in demon side and loose.")
                        .padding()
                    Text("In the case that both players are in the human side when they use up their turns, it will be an Atomatic Tie, thus restart the game.")
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
