//
//  SettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    // GAME SETTINGS
    @State private var playerOneName: String = UserDefaults.standard.string(forKey: "PlayerOneName") ?? "Player1"
    @State private var playerTwoName: String = UserDefaults.standard.string(forKey: "PlayerTwoName") ?? "Player2"
    @State private var playerOneWins: Int16 = 0
    @State private var playerTwoWins: Int16 = 0
    @State private var rounds: Int = UserDefaults.standard.integer(forKey: "Rounds")
    @State private var themeColor: String = UserDefaults.standard.string(forKey: "ThemeColor") ?? "purple"
    
    // SAVE BUTTON VARIABLES
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var scaleAmount: Double = 1.0
    

    
    var body: some View {
        ZStack {
            VStack {
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
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button("Save") {
                        // SAVE SETTINGS TO USERDEFAULTS
                        UserDefaults.standard.set(self.playerOneName, forKey: "PlayerOneName")
                        UserDefaults.standard.set(self.playerTwoName, forKey: "PlayerTwoName")
                        UserDefaults.standard.set(self.rounds, forKey: "Rounds")
                        UserDefaults.standard.set(self.themeColor, forKey: "ThemeColor")
                        
                        gvm.playerOneName = playerOneName
                        gvm.playerTwoName = playerTwoName
                        
                        print("Save settings")
                    }
                    .buttonStyle(DefaultButton(buttonWidth: 70))
//                    .offset(self.dragAmount)
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
//                    .gesture(DragGesture()
//                        .onChanged { self.dragAmount = $0.translation }
//                        .onEnded { _ in
//                            withAnimation(.easeOut.delay(0.5)) {
//                                self.dragAmount = .zero
//                                self.enabled.toggle()
//                            }
//                        })
                }

            }
            
        }
        .accentColor(gsvm.changeThemeColor(themeColor: themeColor))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
