//
//  MoveModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 30.06.22.
//

import Foundation

struct Move: Identifiable {
    let id: String = UUID().uuidString
    let move: String
}
