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
    @State private var randomeValue = 0
    @State private var rotation = 0.0
    var body: some View {
        ZStack {
            Color.brown.opacity(0.7).ignoresSafeArea()
        VStack {
            Image("Logo").resizable().frame(width: 260, height: 260)
            CustomText(text: "Angels, Humans, Demons")
            HStack {
                Image("Demon Dice \(randomeValue)")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(rotation))
                    .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                    .padding()
                
                Image("pips \(randomeValue)")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(rotation))
                    .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                    .padding()
                
                Image("Angel Dice \(randomeValue)")
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
            Spacer()
        }
        //.font(.custom("block_out", size: 26))
      }
    }
    func endTurn() {
        playerOne = 0
        playerTwo = 0
    }
    func chooseRandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline:  .now() + 1) {
                randomeValue = Int.random(in: 1...6)
                chooseRandom(times: times - 1)
            }
        }
        if times == 0 {
            if randomeValue == 1 {
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
