//
//  GameSettings+CoreDataProperties.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 27.06.22.
//
//

import Foundation
import CoreData
import SwiftUI


extension GameScoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameScoreEntity> {
        return NSFetchRequest<GameScoreEntity>(entityName: "GameEntity")
    }

//    @NSManaged public var playerOneImage: Image?
//    @NSManaged public var playerTwoImage: Image?
    @NSManaged public var playerOneName: String?
    @NSManaged public var playerTwoName: String?
    @NSManaged public var playerOneWins: Int16
    @NSManaged public var playerTwoWins: Int16
    @NSManaged public var rounds: Int16
    @NSManaged public var themeColor: String?
    @NSManaged public var gameDate: Date
    
    public var wPlayerOneName: String {
        playerOneName ?? "Player1"
    }
    
    public var wPlayerTwoName: String {
        playerTwoName ?? "Player2"
    }
    
    public var wThemeColor: String {
        themeColor ?? "blue"
    }
}

extension GameScoreEntity : Identifiable {

}
