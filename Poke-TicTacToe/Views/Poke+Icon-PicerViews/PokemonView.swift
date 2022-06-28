//
//  PokemonView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 20.06.22.
//

import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var gvm: GameViewModel
    
    @EnvironmentObject var pvm: PokemonViewModel
    let pokemon: Pokemon
    let dimensions: Double = 140
    
//    @Binding var playerOneImage: Image
//    @Binding var playerTwoImage: Image
    
    @State private var imageHolder: Image = Image(systemName: "questionmark")
    
    var body: some View {
        VStack {
            Menu {
                Button("PlayerOne") {
//                    playerOneImage = imageHolder
                    gvm.playerOneImage = imageHolder
                }
                Button("PlayerTwo") {
//                    playerTwoImage = imageHolder
                    gvm.playerTwoImage = imageHolder
                }
            } label: {
                VStack {
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pvm.getPokemonID(pokemon: pokemon)).png")) { image in
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: dimensions, height: dimensions)
                                .onAppear {
                                    imageHolder = image
                                }
                        }
                    } placeholder: {
                        ProgressView()
                            .frame(width: dimensions, height: dimensions)
                    }
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Text("\(pvm.getPokemonID(pokemon: pokemon)).\(pokemon.name.capitalized)")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .padding(.bottom, 20)
                }

            }
        }
    }
}

//struct PokemonView_Previews: PreviewProvider {
//
//    static private var playerOneImage: Image = Image(systemName: "flame.circle")
//    static private var playerTwoImage: Image = Image(systemName: "snowflake.circle")
//
//    static var previews: some View {
//        PokemonView(pokemon: Pokemon.samplePokemon, playerOneImage: $playerOneImage, playerTwoImage: $playerTwoImage)
//            .environmentObject(PokemonViewModel())
//    }
//}
