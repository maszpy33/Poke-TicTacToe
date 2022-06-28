//
//  SettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    // GAME SETTINGS
    @State private var playerOneName: String = ""
    @State private var playerTwoName: String = ""
    @State private var playerOneWins: Int16 = 0
    @State private var playerTwoWins: Int16 = 0
    @State private var rounds: Int16 = 3
    @State private var gameDate: Date = Date()
    @State private var themeColor: String = "blue"
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name:")) {
                    TextField("player1 name", text: $playerOneName)
                    TextField("player2 name", text: $playerTwoName)
                }
                Section(header: Text("Rounds Picker:")) {
                    Picker("", selection: $rounds) {
                        ForEach(1..<10) {
                            Text("\($0) Rounds")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                }
                
                Section("Theme Color Picker:") {
                    Picker("", selection: $themeColor) {
                        ForEach(gsvm.colors, id: \.self) {
                            Text($0.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Spacer()
                
                Button("Save") {
                    
                }
                .buttonStyle(DefaultButton())
                .padding(.bottom, 15)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
