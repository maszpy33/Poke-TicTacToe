//
//  GameModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 21.06.22.
//

import Foundation

struct Game: Identifiable {
    // id for late to rank games
    let id: String = UUID().uuidString
    var playerOneName: String
    var playerTwoName: String
    var playerOneWins: Int16
    var playerTwoWins: Int16
    var rounds: Int16
    var gameDate: Date
    var themeColor: String
}
