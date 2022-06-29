//
//  GameScoreBoardCell.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct GameScoreBoardCell: View {
    
    var gameData: GameScoreEntity
    var movesHistPlaceholder: [String] = ["X","O","O","X","O","","","","X"]
    
    @State private var showBoardHistView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(header:
                        HStack {
                Text("Game Score: ")
                Text(gameData.gameDate, style: .date)
                    .font(.subheadline)
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Text("Names: ")
                                .bold()
                            Text("Wins: ")
                                .bold()
                        }
                        VStack {
                            Text("\(gameData.wPlayerOneName)")
                            Text("\(gameData.playerOneWins)")
                        }
                        VStack {
                            Text("\(gameData.wPlayerTwoName)")
                            Text("\(gameData.playerTwoWins)")
                        }
                        
                        Spacer()
                        
                        Text("View Board")
                            .bold()
                            .padding(7)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 2))
                            .foregroundColor(.purple)
                        
                    }
                }
            }
        }
        .onTapGesture {
            withAnimation(.linear) {
                showBoardHistView = true
            }
        }
        .sheet(isPresented: $showBoardHistView) {
            BoardHistView(gameData: gameData, movesHist: movesHistPlaceholder)
        }
        .accentColor(Color.purple)
    }
}

struct GameScoreBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameScoreBoardCell(gameData: GameScoreEntity())
    }
}
