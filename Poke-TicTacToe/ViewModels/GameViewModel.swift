//
//  GameViewModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import Foundation
import SwiftUI


final class GameViewModel: ObservableObject {
    
    // GAME LOGIC DATA
    @Published var moves: [String] = ["","","","","","","","",""]
    @Published var endGameText: String = "TicTacToe"
    @Published var gameEnded: Bool = false
    @Published var botIsMoving: Bool = false
    @Published var blockBoard: Bool = false
    
    // SETTINGS DATA
    @Published var playerOneImage: Image = Image(systemName: "xmark")
    @Published var playerTwoImage: Image = Image(systemName: "circle")
    @Published var playerOneWins: Int16 = 0
    @Published var playerTwoWins: Int16 = 0
    
    @Published var roundCount: Int16 = 0
    @Published var disableSaveButton: Bool = true
    
    // ALERT VARIABLES
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    // USERDEFAULTS DATA
    @Published var playerOneName: String {
        didSet {
            UserDefaults.standard.set(playerOneName, forKey: "PlayerOneName")
        }
    }
    
    @Published var playerTwoName: String {
        didSet {
            UserDefaults.standard.set(playerTwoName, forKey: "PlayerTwoName")
        }
    }
    
    @Published var rounds: Int {
        didSet {
            UserDefaults.standard.set(rounds, forKey: "GameRounds")
        }
    }
    
    @Published var themeColorPrimary: String {
        didSet {
            UserDefaults.standard.set(themeColorPrimary, forKey: "ThemeColorPrimary")
        }
    }
    
    @Published var themeColorSecondary: String {
        didSet {
            UserDefaults.standard.set(themeColorSecondary, forKey: "ThemeColorSecondary")
        }
    }
    
    @Published var resetGridOffset: Double = 0.0
//    @Published var playerOneColor: Color = .red
    
    @Published var imageArr: [(String, Image)] = [("X", Image(systemName: "flame.circle")), ("O", Image(systemName: "snowflake.circle"))]
    
    let ranges = [(0..<3),(3..<6),(6..<9)]
    
    
    init() {
        self.playerOneName = UserDefaults.standard.object(forKey: "PlayerOneName") as? String ?? "Player1"
        self.playerTwoName = UserDefaults.standard.object(forKey: "PlayerTwoName") as? String ?? "Player2"
        self.rounds = UserDefaults.standard.object(forKey: "GameRounds") as? Int ?? 1
        self.themeColorPrimary = UserDefaults.standard.object(forKey: "ThemeColorPrimary") as? String ?? "purple"
        self.themeColorSecondary = UserDefaults.standard.object(forKey: "ThemeColorSecondary") as? String ?? "blue"
    }
    
    
    // ****************************
    // ******** GAME LOGIC ********
    // ****************************
    
    func resetGame() {
        blockBoard = true
        endGameText = "TicTacToe"
        botIsMoving = false
        gameEnded = false
        
        if rounds == roundCount {
            roundCount = 0
            // CHANGE WHEN PLAYER CAN SELECT MULTIPLE ROUNDS
            playerOneWins = 0
            playerTwoWins = 0
        }
        
        // animate grid refresh
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
        
        // disable save button again
        disableSaveButton = true
    }
    
    func resetFullGame() {
        roundCount = 0
        // CHANGE WHEN PLAYER CAN SELECT MULTIPLE ROUNDS
        playerOneWins = 0
        playerTwoWins = 0
        
        resetGame()
    }
    
    func playerTap(index: Int) {
        guard !botIsMoving else {
            print("bot is moving")
            return
        }
        
        guard !gameEnded else {
            print("gameEnded: \(gameEnded)")
            print("game ended please press reset or save")
            return
        }
        
        botIsMoving = true
        
        if moves[index] == "" {
            // occupie empty field
            moves[index] = "X"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.3 ..< 1.0)) { [self] in
                // check if player1 has already won the game so bot dose not have to move anymore
                if !self.checkWinner(list: self.moves, letter: "X") {
                    self.botMove()
                } else {
                    // player1 has won -> raise count by 1
                    self.roundCount += 1
                    
                    // disableSaveButton also toggled to false here becaus of async
                    self.checkIfGameEnde()
                }
                
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
                    // raise roundCount here, because bot move won't be executet anymore
                    roundCount += 1
                }
                
                alertHelper(letter: letter)
                
                break
            }
        }
        
        // if last round is done enable save button
        if rounds == roundCount {
            disableSaveButton = false
        }
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
        
        // bot always makes the last move so if there is no empty field left raise roundCount by one
        if moves.filter({ $0 == "" }).count == 0 {
            roundCount += 1
        }
        
        // Check if bot has won
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGameText = "\(letter) has won!"
                gameEnded = true
                if letter == "O" {
                    playerTwoWins += 1
                    roundCount += 1
                }
                
                alertHelper(letter: letter)
                checkIfGameEnde()
                
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
    
    
    // ****************************
    // ***** HELPER FUNCTIONS *****
    // ****************************
    
    func alertHelper(letter: String) {
        let playerHasWoneName = getPlayerNameAndWins(letter: letter)
        
        guard rounds == roundCount else {
            print("End of one game")
            alertTitle = "🥳 Yeah \(playerHasWoneName.0) has won!"
            alertMessage = "Congrats my friend, that was your \(playerHasWoneName.1) win!"
            showAlert = true
            return
        }
        
        if playerOneWins != playerTwoWins {
            print("End of Game")
            alertTitle = "🥳 \(playerHasWoneName.0) has won the Game of TTT"
            alertMessage = "🏆 \(playerHasWoneName.0) won \(playerHasWoneName.1) games out of \(rounds)"
        } else {
            print("End of Game it is a draw")
            alertTitle = "🙅🏻‍♂️ it's a draw"
            alertMessage = "\(playerOneName) wins: \(playerOneWins)\n\(playerTwoName) wins: \(playerTwoWins)"
        }
        
        showAlert = true
    }
    
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
    
    func getPlayerNameAndWins(letter: String) -> (String, Int16) {
        switch letter {
        case "X":
            return (playerOneName, playerOneWins)
        case "O":
            return (playerTwoName, playerTwoWins)
        default:
            return ("Error", 404)
        }
    }
    
    func checkIfGameEnde() {
        guard rounds != roundCount else {
            // enable save button if game has ended
            disableSaveButton = false
            return
        }
        disableSaveButton = true
    }
    
    // check board array if field is already occupied
    func isFieldOccupied(index: Int) -> Bool {
        guard self.moves[index] != "" else {
            return false
        }
        
        return true
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
