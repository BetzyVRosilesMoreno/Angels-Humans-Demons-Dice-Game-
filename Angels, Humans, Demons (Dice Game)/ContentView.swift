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
            CustomText(text: "player Two: \(playerTwo)")
            Spacer()
        }
        .font(.custom("block_out", size: 26))
      }
    }
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("block_out", size: 36))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
