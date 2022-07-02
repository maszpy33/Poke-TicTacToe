//
//  SettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    var body: some View {
        List {
            Text("ScoreBoard:")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            ForEach(gsvm.searchGames, id: \.self) { gameData in
                GameScoreBoardCell(gameData: gameData, themeColorPrimary: gvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            withAnimation(.linear(duration: 0.4)) {
                                gsvm.deleteGameScore(gameScoreID: gameData.id)
                            }

                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .tint(.red)
            }
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBoardView()
    }
}
