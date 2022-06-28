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
        VStack {
            Text(gvm.endGameText)
                .font(.title)
                .padding()
                .alert(gvm.endGameText, isPresented: $gvm.gameEnded) {
                    Button("Reset", role: .destructive, action: gvm.resetGame)
                }
            
            HStack {
                VStack {
                    Text(gvm.playerOneName)
                        .foregroundColor(gvm.botIsMoving ? .gray : .primary)
                    gvm.playerOneImage
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 20)
                
                VStack {
                    Text(gvm.playerTwoName)
                        .foregroundColor(gvm.botIsMoving ? .primary : .gray)
                    gvm.playerTwoImage
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 80)
            
            Spacer()
            
            ForEach(gvm.ranges, id: \.self) { range in
                HStack {
                    ForEach(range, id: \.self) { i in
                        XOButton(letter: $gvm.moves[i], isOccupied: $isOccupied)
                            .environmentObject(gvm)
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
            }
            
            Spacer()
            
            // SAVE AND RESET BUTTON
            HStack {
                Spacer()
                
                Button {
                    gsvm.saveGameData(playerOneName: gvm.playerOneName, playerTwoName: gvm.playerTwoName, playerOneWins: gvm.playerOneWins, playerTwoWins: gvm.playerTwoWins, rounds: 1, gameData: Date(), themeColor: "purple")
                    print("saved game")
                    gvm.resetGame()
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Save Score")
                    }
                }
                .buttonStyle(DefaultButton(buttonWidth: 140))
                
                Button {
                    gvm.resetGame()
                } label: {
                    HStack {
                        Image(systemName: "arrow.rectanglepath")
                        Text("Reset")
                    }
                }
                .buttonStyle(DefaultButton(buttonWidth: 140))
                
                Spacer()
            }
            .padding(.horizontal, 10)

            
//            Button("Reset") {
//                gvm.resetGame()
//            }
//            .buttonStyle(ResetButton())
//            .padding(.bottom)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.dark)
    }
}
