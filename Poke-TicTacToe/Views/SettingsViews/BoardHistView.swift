//
//  BoardHistView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 30.06.22.
//

import SwiftUI

struct BoardHistView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    
    @State var gameData: GameScoreEntity
    @State var movesHist: [String]
    @State var isOccupied: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Game Date: ")
                    Text(gameData.gameDate, style: .date)
                        .bold()
                }
                
                HStack {
                    VStack {
                        Text(gameData.wPlayerOneName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(gvm.botIsMoving ? .gray : .primary)
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Text(gameData.wPlayerTwoName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(gvm.botIsMoving ? .primary : .gray)
                        
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 80)
                .padding(.bottom, 20)
                
                ForEach(gvm.ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            XOButton(letter: $movesHist[i], isOccupied: $isOccupied)
                                .environmentObject(gvm)
                        }
                    }
                    .offset(x: gvm.resetGridOffset, y: 0.0)
                }
                
                Spacer()
            }
            .navigationTitle("GameBoard History:")
        }
    }
}

struct BoardHistView_Previews: PreviewProvider {
    static var previews: some View {
        BoardHistView(gameData: GameScoreEntity(), movesHist: ["X","O","O","X","O","","","","X"])
    }
}
