//
//  GameSettings+CoreDataProperties.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 27.06.22.
//
//

import Foundation
import CoreData


extension GameSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameSettings> {
        return NSFetchRequest<GameSettings>(entityName: "GameSettings")
    }

    @NSManaged public var playerOneImage: Image?
    @NSManaged public var playerTwoImage: Image?
    @NSManaged public var playerOneName: String?
    @NSManaged public var playerTwoName: String?
    @NSManaged public var playerOneWins: Int16
    @NSManaged public var playerTwoWins: Int16
    @NSManaged public var rounds: Int16

}

extension GameSettings : Identifiable {

}
