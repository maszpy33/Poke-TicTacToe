//
//  PokemonViewModel.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 20.06.22.
//

import Foundation
import SwiftUI


final class PokemonViewModel: GameViewModel {
    // pokemonManager for networking stuff
    private let pokemonManager = PokeManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    @Published var iconList: [String] = ["globe.europe.africa.fill", "flame.fill", "drop.fill", "hare.fill", "bolt.fill", "tortoise.fill", "pawprint.fill", "ant.fill", "ladybug.fill", "leaf.fill"]
    
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    override init() {
        super.init()
        
        self.pokemonList = pokemonManager.getPokemon()
        self.iconList = iconList
        //        print(self.pokemonList)
    }
    
    func getPokemonID(pokemon: Pokemon) -> Int {
        if let id = self.pokemonList.firstIndex(of: pokemon) {
            return id + 1
        }
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonID(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
//    func randomPokemon() {
//        let randPokeID = Int.random(in: 1..<152)
//        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(randPokeID).png")!
//
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = Image(data) {
//                    DispatchQueue.main.async {
//                        self?.playerOneImage = image
//                    }
//                }
//            }
//        }
//    }
    
    func randomIcon() -> Image {
        let randIconID = Int.random(in: 0..<iconList.count)
        let playerImage = Image(systemName: iconList[randIconID])
        
        return playerImage
    }
}
