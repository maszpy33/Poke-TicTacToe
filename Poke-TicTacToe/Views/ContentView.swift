//
//  ContentView.swift
//  TicTacToe-CatEdition
//
//  Created by Andreas Zwikirsch on 03.05.22.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var gvm = GameViewModel()
    @StateObject var pvm = PokemonViewModel()
    @StateObject var gsvm = GameScoreViewModel()

    var body: some View {
        TabView {
            GameView()
                .environmentObject(gvm)
                .environmentObject(gsvm)
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game")
                }
            
            MainSettingsView()
                .environmentObject(gvm)
                .environmentObject(gsvm)
//            Text("SettingsView")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
            MainPickerView()
                .environmentObject(pvm)
                .environmentObject(gvm)
                .tabItem {
                    Image(systemName: "photo")
                    Text("PokePicker")
                }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
