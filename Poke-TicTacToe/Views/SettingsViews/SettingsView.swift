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
    @State private var currentDragOffsetX = CGFloat.zero
    @State private var currentDragOffsetY = CGFloat.zero
    
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
                    
                    Text("Save")
                        .frame(width: 70)
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 30)
                        .scaleEffect(self.scaleAmount)
                        .offset(x: currentDragOffsetX)
//                        .offset(y: currentDragOffsetY)
                        .padding()
                        .onTapGesture {
                            // ANIMATE BUTTON EFFECT WHILE MAINTING DRAG GESTURE
                            DispatchQueue.main.async {
                                withAnimation(.default) {
                                    scaleAmount = 0.7
                                }
                                withAnimation(.default.delay(0.2)) {
                                    scaleAmount = 1.0
                                }
                            }
                            
                            // SAVE SETTINGS TO USERDEFAULTS
                            UserDefaults.standard.set(self.playerOneName, forKey: "PlayerOneName")
                            UserDefaults.standard.set(self.playerTwoName, forKey: "PlayerTwoName")
                            UserDefaults.standard.set(self.rounds, forKey: "Rounds")
                            UserDefaults.standard.set(self.themeColor, forKey: "ThemeColor")
                            
                            gvm.playerOneName = playerOneName
                            gvm.playerTwoName = playerTwoName
                            
                            print("Save settings")
                        }
                        .gesture(DragGesture()
                            .onChanged { value in
//                                self.offsetAmountX = $0.translation
//                                self.offsetAmountY = $0.translation
                                withAnimation(.spring()) {
                                    currentDragOffsetX = value.translation.width
//                                    currentDragOffsetY = value.translation.height
                                }
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    if currentDragOffsetX < -260 {
                                        currentDragOffsetX = -260
                                    } else if currentDragOffsetX >= 0.0 {
                                        currentDragOffsetX = 0.0
                                    }
//                                    currentDragOffsetY = .zero
                                    self.enabled.toggle()
                                }
                            })
                }

            }
            
//
//            Text("\(currentDragOffsetX)")
//                .font(.title)
//                .foregroundColor(.white)
//
            
        }
        .accentColor(gsvm.changeThemeColor(themeColor: themeColor))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
