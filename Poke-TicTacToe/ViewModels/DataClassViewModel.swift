//
//  DataClassViewModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 27.06.22.
//

import Foundation
import CoreData
import SwiftUI


class DataClassViewModel: Identifiable, ObservableObject {
    
    @Published var savedGames: [GameScoreEntity] = []
    
    // COREDATA STUFF
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "PTTTGameCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unabel to initialize Core Data \(error)")
            } else {
                print("Successfully looaded core data!")
            }
        }
        fetchGame()
    }
    
    func fetchGame() {
        let request = NSFetchRequest<GameScoreEntity>(entityName: "GameScoreEntity")
        let sortDate = NSSortDescriptor(key: "gameDate", ascending: true)
        request.sortDescriptors = [sortDate]
        
        do {
            savedGames = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching tasks. \(error)")
        }
    }
}
