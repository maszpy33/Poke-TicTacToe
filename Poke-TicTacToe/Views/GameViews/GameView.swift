//
//  BoardView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    @State var playerOneImage: Image = Image(systemName: "flame.circle")
    @State var playerTwoImage: Image = Image(systemName: "snowflake.circle")
    
    @State var boardIndex: Int = 0
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    @State private var degrees = 0.0
    @State private var playerImage: Image = Image(systemName: "circle.fill")
    
    @State var isOccupied: Bool = false
    
    // ALERT VARIABLES
//    @State private var showAlert = false
//    @State private var errorTitle = ""
//    @State private var errorMessage = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
//                Text(gvm.endGameText)
//                    .font(.title)
//                    .padding()
//                    .alert(gvm.endGameText, isPresented: $gvm.gameEnded) {
//                        Button("Reset", role: .destructive, action: gvm.resetGame)
//                    }
                
                HStack {
                    
                    VStack {
                        Text("Score")
                        Text("\(gvm.playerOneWins)")
//                        Text(gvm.gameEnded ? "gameEnded: True" : "gameEnded: False")
                    }
                    
                    VStack {
                        Text(gvm.playerOneName)
                            .bold()
                            .foregroundColor(gvm.botIsMoving ? .gray : .primary)
                        gvm.playerOneImage
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: gvm.botIsMoving ? 0 : 10)
                            .shadow(color: .red, radius: gvm.botIsMoving ? 0 : 10)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Text(gvm.playerTwoName)
                            .bold()
                            .foregroundColor(gvm.botIsMoving ? .primary : .gray)
                        gvm.playerTwoImage
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .shadow(color: .blue, radius: gvm.botIsMoving ? 10 : 0)
                            .shadow(color: .blue, radius: gvm.botIsMoving ? 10 : 0)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Text("Score")
                        Text("\(gvm.playerTwoWins)")
                    }
                }
                .frame(height: 60)
                
                Text("Round \(gvm.roundCount) of \(gvm.rounds)")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(5)
                
                Spacer()
                
                ForEach(gvm.ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            XOButton(letter: $gvm.moves[i], isOccupied: $isOccupied)
                                .environmentObject(gvm)
                                .environmentObject(gsvm)
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            boardIndex = i
                                            print("Tap: \(i)")
                                            if !gvm.blockBoard {
                                                gvm.playerTap(index: i)
                                            }
                                        }
                                )
                        }
                    }
                    .offset(x: gvm.resetGridOffset, y: 0.0)
                    // ALERTS
                    .alert(gvm.endGameText, isPresented: $gvm.gameEnded) {
                        Button("Reset", role: .destructive, action: gvm.resetGame)
                    }
                }
                
                Spacer()
                
                // SAVE AND RESET BUTTON
                HStack {
                    Spacer()
                    
                    Button {
                        gsvm.saveGameData(playerOneName: gvm.playerOneName, playerTwoName: gvm.playerTwoName, playerOneWins: gvm.playerOneWins, playerTwoWins: gvm.playerTwoWins, rounds: Int16(gvm.rounds), gameData: Date(), themeColor: gvm.themeColorPrimary)
                        print("saved game")
                        gvm.resetGame()
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.down.fill")
                            Text("Save Score")
                        }
                    }
                    .disabled(gvm.disableSaveButton == true)
                    .buttonStyle(DefaultButton(buttonWidth: 140, themeColorPrimary: gvm.changeThemeColor(themeColor: gvm.themeColorPrimary), themeColorSecondary: gvm.changeThemeColor(themeColor: gvm.themeColorSecondary)))
                    .opacity(gvm.disableSaveButton ? 0.7 : 1.0)
                    
                    Button {
                        gvm.resetGame()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.rectanglepath")
                            Text("Reset")
                        }
                    }
                    .buttonStyle(DefaultButton(buttonWidth: 140, themeColorPrimary: gvm.changeThemeColor(themeColor: gvm.themeColorPrimary), themeColorSecondary: gvm.changeThemeColor(themeColor: gvm.themeColorSecondary)))
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .accentColor(gvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
            .navigationBarTitle("\(gvm.endGameText)")
            .navigationBarItems(trailing:
                                    Button("Reset Game") {
                gvm.resetFullGame()
            })
        }
//        .alert(isPresented: $gvm.showAlert) {
//            Alert(
//                title: Text(gvm.alertTitle)),
//                message: Text(gvm.alertMessage),
//        primaryButton: .default(Text("Continue")) {
//            // do nothing just disable board
//            print("continue")
//        }, secondaryButton: .cancel() {
//            gvm.resetGame()
//        }
//
//        }
//        .alert(isPresented: $gvm.showAlert) {
//            Alert(title: Text(gvm.alertTitle), message: Text(gvm.alertMessage), dismissButton: .default(Text("OK")))
//        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.dark)
    }
}
