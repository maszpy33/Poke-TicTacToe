//
//  GameViewModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import Foundation
import SwiftUI


final class GameViewModel: ObservableObject {
    
    @Published var moves: [String] = ["","","","","","","","",""]
    @Published var endGameText: String = "TicTacToe"
    @Published var gameEnded: Bool = false
    @Published var botIsMoving: Bool = false
    @Published var blockBoard: Bool = false
    
    @Published var playerOneName: String = "Player1"
    @Published var playerTwoName: String = "Player2"
    
    @Published var playerOneImage: Image = Image(systemName: "xmark")
    @Published var playerTwoImage: Image = Image(systemName: "circle")
    @Published var playerOneWins: Int16 = 0
    @Published var playerTwoWins: Int16 = 0
    
    @Published var resetGridOffset: Double = 0.0
    
    @Published var playerOneColor: Color = .red
    
    @Published var imageArr: [(String, Image)] = [("X", Image(systemName: "flame.circle")), ("O", Image(systemName: "snowflake.circle"))]
    
    let ranges = [(0..<3),(3..<6),(6..<9)]
    
    
    func getPlayerImage(letter: String) -> Image {
        switch letter {
        case "X":
            return playerOneImage
        case "O":
            return playerTwoImage
        default:
            return Image(systemName: "questionmark")
        }
    }
    
    func resetGame() {
        blockBoard = true
        endGameText = "TicTacToe"
        botIsMoving = false
        
        // CHANGE WHEN PLAYER CAN SELECT MULTIPLE ROUNDS
        playerOneWins = 0
        playerTwoWins = 0
        
        withAnimation(.easeOut(duration: 0.5)) {
            self.resetGridOffset -= 400
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resetGridOffset += 800
            withAnimation(.easeOut(duration: 0.5)) {
                self.resetGridOffset -= 400
                self.moves = ["","","","","","","","",""]
            }
            self.blockBoard = false
        }
        
    }
    
    func playerTap(index: Int) {
        guard !botIsMoving else {
            print("bot is moving")
            return
        }
        botIsMoving = true
        // set botIsMoving to true so player can not tap twice before bot moves
//        botIsMoving = true
        
        if moves[index] == "" {
            moves[index] = "X"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.3 ..< 1.0)) {
                self.botMove()
                // set it back to false so player1 can move
                self.botIsMoving = false
            }
        }
        
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGameText = "\(letter) has won!"
                gameEnded = true
                if letter == "X" {
                    playerOneWins += 1
                } else {
                    playerTwoWins += 1
                }
                break
            }
        }
    }
    
    func isFieldOccupied(index: Int) -> Bool {
        guard self.moves[index] != "" else {
            return false
        }
        
        return true
    }
    
    func botMove() {
        var availableMoves: [Int] = []
        var movesLeft = 0
        
        // Check the available moves left
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        // Make sure there are moves left before bot moves
        if availableMoves.count != 0 && !blockBoard {
            moves[availableMoves.randomElement()!] = "O"
        }
        
        // Logging
        print("AvaliableMoves: \(availableMoves)")
        
        // Check if bot has won
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGameText = "\(letter) has won!"
                gameEnded = true
                break
            }
        }
    }
    
    
    func checkWinner(list: [String], letter: String) -> Bool {
        let winningSequences = [
            // Horizontal rows
            [ 0, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ],
            // Diagonals
            [ 0, 4, 8 ], [ 2, 4, 6 ],
            // Vertical rows
            [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ],
        ]
        
        for sequence in winningSequences {
            var score = 0
            
            for match in sequence {
                if list[match] == letter {
                    score += 1
                    
                    if score == 3 {
                        print("\(letter) has won!")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func changeThemeColor(themeColor: String) -> Color {
        switch themeColor {
        case "blue":
            return Color.blue
        case "orange":
            return Color.orange
        case "red":
            return Color.red
        case "green":
            return Color.green
        case "purple":
            return Color.purple
        default:
            return Color.blue
        }
    }
}
