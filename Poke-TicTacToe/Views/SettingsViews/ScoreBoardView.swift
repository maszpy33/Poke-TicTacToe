//
//  SettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    var body: some View {
        List {
            Text("ScoreBoard:")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            ForEach(gsvm.searchGames, id: \.self) { gameData in
                GameScoreBoardCell(gameData: gameData)
            }
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBoardView()
    }
}
