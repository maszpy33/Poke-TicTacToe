//
//  PokemonPickerView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 20.06.22.
//

import SwiftUI

struct PokemonPickerView: View {
    @EnvironmentObject var pvm: PokemonViewModel
    @EnvironmentObject var gvm: GameViewModel
    
    private let adaptiveColomns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColomns, spacing: 10) {
                        ForEach(pvm.filteredPokemon) { pokemon in
                            PokemonView(pokemon: pokemon)
                                .environmentObject(gvm)
                        }
                    }
                    .animation(.easeIn(duration: 0.3), value: pvm.filteredPokemon.count)
                    .navigationTitle("Poke-Picker")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .searchable(text: $pvm.searchText)
            }

        }
        .environmentObject(pvm)
    }
}

struct PokemonPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPickerView()
            .preferredColorScheme(.dark)
    }
}
