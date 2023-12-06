//
//  ContentView.swift
//  Angels, Humans, Demons (Dice Game)
//
//  Created by Betzy Moreno on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.brown.opacity(0.7).ignoresSafeArea()
        VStack {
            Image("Logo").resizable().frame(width: 260, height: 260)
            Text("Angels, Humans, Demons")
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
