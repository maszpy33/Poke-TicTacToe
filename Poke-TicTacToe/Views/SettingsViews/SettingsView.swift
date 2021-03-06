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
    @State private var playerOneWins: Int16 = 0
    @State private var playerTwoWins: Int16 = 0
    
    // SAVE BUTTON VARIABLES
    @State private var currentDragOffsetX = CGFloat.zero
    @State private var currentDragOffsetY = CGFloat.zero
    
    @State private var enabled = false
    @State private var scaleAmount: Double = 1.0
    
    
    var body: some View {
//        ZStack {
            VStack {
                Form {
                    
                    Section(header: Text("Name:")) {
                        TextField("player1 name", text: $gvm.playerOneName)
                        TextField("player2 name", text: $gvm.playerTwoName)
                    }
                    
                    Section(header: Text("Rounds Picker:")) {
                        Picker("", selection: $gvm.rounds) {
                            ForEach(1..<11, id: \.self) {
                                Text("\($0) Rounds")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 150)
                    }
                    
                    Section("Theme Color Picker:") {
                        
                        Text("Primary:")
                            .font(.subheadline)
                        Picker("", selection: $gvm.themeColorPrimary) {
                            ForEach(gsvm.colors, id: \.self) {
                                Text($0.capitalized)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("Secondary:")
                            .font(.subheadline)
                        Picker("", selection: $gvm.themeColorSecondary) {
                            ForEach(gsvm.colors, id: \.self) {
                                Text($0.capitalized)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(10)
                }
            }
            .onAppear {
                print("ROUNDS: \(gvm.rounds)")
            }
            .accentColor(gsvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
            // Settings are automatically saved with Userdefaults
//            // SAVE BUTTON
//            VStack {
//                Spacer()
//
//                HStack {
//                    Spacer()
//
//                    Text("Save")
//                        .frame(width: 70)
//                        .padding()
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.black)
//                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .padding(.bottom, 30)
//                        .scaleEffect(self.scaleAmount)
//                        .offset(x: currentDragOffsetX)
////                        .offset(y: currentDragOffsetY)
//                        .padding()
//                        .onTapGesture {
//                            // ANIMATE BUTTON EFFECT WHILE MAINTING DRAG GESTURE
//                            DispatchQueue.main.async {
//                                withAnimation(.default) {
//                                    scaleAmount = 0.7
//                                }
//                                withAnimation(.default.delay(0.2)) {
//                                    scaleAmount = 1.0
//                                }
//                            }
//                        }
//                        .gesture(DragGesture()
//                            .onChanged { value in
////                                self.offsetAmountX = $0.translation
////                                self.offsetAmountY = $0.translation
//                                withAnimation(.spring()) {
//                                    currentDragOffsetX = value.translation.width
////                                    currentDragOffsetY = value.translation.height
//                                }
//                            }
//                            .onEnded { _ in
//                                withAnimation(.spring()) {
//                                    if currentDragOffsetX < -260 {
//                                        currentDragOffsetX = -260
//                                    } else if currentDragOffsetX >= 0.0 {
//                                        currentDragOffsetX = 0.0
//                                    }
////                                    currentDragOffsetY = .zero
//                                    self.enabled.toggle()
//                                }
//                            })
//                }
//
//            }
//        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
