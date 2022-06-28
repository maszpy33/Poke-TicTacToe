//
//  GameScoreBoardCell.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct GameScoreBoardCell: View {
    
    var gameData: GameScoreEntity
    
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
                            Text("Scores: ")
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
                        
                    }
                }
            }
        }
    }
}

struct GameScoreBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameScoreBoardCell(gameData: GameScoreEntity())
    }
}
