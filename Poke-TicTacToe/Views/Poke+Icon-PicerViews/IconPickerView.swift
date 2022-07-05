//
//  IconPickerView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 26.06.22.
//

import SwiftUI

struct IconPickerView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var pvm: PokemonViewModel
    
    private let adaptiveColomns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var imageHolder: Image = Image(systemName: "questionmark")
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColomns, spacing: 10) {
                    ForEach(pvm.iconList, id: \.self) { playerIconString in
                        Menu {
                            Button("PlayerOne") {
                                gvm.playerOneImage = Image(systemName: playerIconString)
                            }
                            Button("PlayerTwo") {
                                gvm.playerTwoImage =
                                Image(systemName: playerIconString)
                            }
                        } label: {
                            Image(systemName: playerIconString)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 85, height: 85)
                                .foregroundColor(.primary)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
            }
            .navigationTitle("Icon-Picker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView()
    }
}
