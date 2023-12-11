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
    var body: some View {
        ZStack {
            Color.brown.opacity(0.7).ignoresSafeArea()
        VStack {
            Image("Logo").resizable().frame(width: 260, height: 260)
            CustomText(text: "Angels, Humans, Demons")
                .font(.custom("block_out", size: 16))
            Spacer()
            CustomText(text: "player One: \(playerOne)")
            CustomText(text: "player Two: \(playerTwo)")
            Spacer()
        }
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
