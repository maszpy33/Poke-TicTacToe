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
    
    
    var body: some View {
        NavigationView {
            VStack {
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
                    //                    .alert(gvm.endGameText, isPresented: $gvm.gameEnded) {
                    //                        Alert(
                    //                        title: Text("Continue"),
                    //                        message: )
                    //                    }
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
            .navigationBarTitle("\(gvm.endGameText)")
            .navigationBarItems(leading: NavigationLink(destination:
                                                            ScoreBoardView()
                .environmentObject(gvm)
                .environmentObject(gsvm)) {
                    HStack {
                        Image(systemName: "list.number")
                        Text("Score Board")
                    }
                }
                                , trailing:
                                    Button(action: gvm.resetFullGame) {
                HStack {
                    Image(systemName: "hurricane")
                    Text("Reset Full Game")
                }
            }
            )
        }
        .accentColor(gvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
        .alert(isPresented: $gvm.showAlert) {
            Alert(
                title: Text(gvm.alertTitle),
                message: Text(gvm.alertMessage),
                primaryButton: .cancel(Text("View Board")) {
                }, secondaryButton: .default(Text("Reset Board"), action: gvm.resetGame)
            )
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.dark)
    }
}
