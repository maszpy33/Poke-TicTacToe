//
//  MainPickerView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 26.06.22.
//

import SwiftUI

struct MainPickerView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var pvm: PokemonViewModel
    
    @State private var pickerViewSwitch: Bool = false
    
    @State private var secondaryColor: Color = Color.purple
    
    @State private var randPokePlaceholderOne: Image = Image(systemName: "leaf")
    @State private var randPokePlaceholderTwo: Image = Image(systemName: "leaf")
    @State private var randIDOne = 1
    @State private var randIDTwo = 1
    
    var body: some View {
        VStack {
            HStack {
                // PLAYER ONE MENU
                Menu {
                    VStack {
                        Button("Random Icon \(gvm.playerOneName)") {
                            gvm.playerOneImage = pvm.randomIcon()
                        }

                        Button(action: {
                            randIDOne = Int.random(in: 1..<152)
                        }, label: {
                            HStack {
                                Text("Random Pokemon \(gvm.playerOneName)")
                                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(randIDOne).png")) { image in
                                    if let image = image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .onAppear {
                                                gvm.playerOneImage = image
                                            }
                                    }
                                } placeholder: {
                                    ProgressView()
//                                        .frame(width: dimensions, height: dimensions)
                                }
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        })
                    }
                    
                } label: {
                    HStack {
                        Text("Player One ")
                            .bold()
                        gvm.playerOneImage
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 50)
                    .padding()
                }
                
                // PLAYER TWO MENU
                Menu {
                    VStack {
                        Button("Random Icon \(gvm.playerTwoName)") {
                            gvm.playerTwoImage = pvm.randomIcon()
                        }
                        
                        Button(action: {
                            randIDTwo = Int.random(in: 1..<152)
                        }, label: {
                            HStack {
                                Text("Random Pokemon \(gvm.playerOneName)")
                                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(randIDTwo).png")) { image in
                                    if let image = image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .onAppear {
                                                gvm.playerTwoImage = image
                                            }
                                    }
                                } placeholder: {
                                    ProgressView()
//                                        .frame(width: dimensions, height: dimensions)
                                }
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        })
                    }
                    
                } label: {
                    HStack {
                        Text(" Player Two")
                            .bold()
                        gvm.playerTwoImage
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 50)
                    .padding()
                }
            }
            .foregroundColor(gvm.changeThemeColor(themeColor: gvm.themeColorSecondary))
            
            CustomToggleSwitch(pickerViewSwitch: $pickerViewSwitch, leftButtonText: "Pokemon", rightButtonText: "Icons")
                .environmentObject(gvm)
                .padding(.horizontal, 20)
                .offset(x: 5)
            
            if !pickerViewSwitch {
                PokemonPickerView()
                    .environmentObject(gvm)
                    .environmentObject(pvm)
            } else {
                IconPickerView()
                    .environmentObject(gvm)
                    .environmentObject(pvm)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    print("random stuff")
                }, label: {
                    HStack {
                        Image(systemName: "r.square")
                        Text("Random Icon")
                    }
                })
            }
        }
        .accentColor(gvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
    }
}

struct MainPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MainPickerView()
    }
}
