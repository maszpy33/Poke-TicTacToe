//
//  PlayerViewModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import Foundation
import CoreData
import SwiftUI


final class GameScoreViewModel: DataClassViewModel {
    
    // DATEFORMATTER
    let dateFormatter = DateFormatter()
    
    // COLOR PLATE
    let colors = ["blue", "orange", "red", "green", "purple"]

    @Published var searchText = ""
    
    // SEARCH GAME WRAPPER
    var searchGames: [GameScoreEntity] {
        return searchText == "" ? savedGames : savedGames.filter {
            $0.wPlayerOneName.lowercased().contains(searchText.lowercased())
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
            fetchGame()
        } catch {
            print("Error saving game. \(error)")
        }
    }
    
    func saveGameData(playerOneName: String, playerTwoName: String, playerOneWins: Int16, playerTwoWins: Int16, rounds: Int16, gameData: Date, themeColor: String) {
        let newGameData = GameScoreEntity(context: container.viewContext)
        newGameData.playerOneName = playerOneName
        newGameData.playerTwoName = playerTwoName
        newGameData.playerOneWins = playerOneWins
        newGameData.playerTwoWins = playerTwoWins
        newGameData.rounds = rounds
        newGameData.gameDate = gameData
        newGameData.themeColor = themeColor
        
        save()
    }
    
    func deleteGameScore(gameScoreID: ObjectIdentifier) {
        guard let gameScoreEntity = savedGames.first(where: { $0.id == gameScoreID }) else { return }
        
        container.viewContext.delete(gameScoreEntity)
        save()
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
