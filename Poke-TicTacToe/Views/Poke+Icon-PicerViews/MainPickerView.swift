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
    
    var body: some View {
        VStack {
            HStack {
                Text("Player One ")
                    .bold()
                gvm.playerOneImage
                    .resizable()
                    .scaledToFit()
                
                Text(" Player Two")
                    .bold()
                gvm.playerTwoImage
                    .resizable()
                    .scaledToFit()
            }
            .frame(height: 50)
            .padding()
            
            CustomToggleSwitch(pickerViewSwitch: $pickerViewSwitch, leftButtonText: "Pokemon", rightButtonText: "Icons", buttonColor: gvm.changeThemeColor(themeColor: "purple"))
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
    }
    
    
}

struct MainPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MainPickerView()
    }
}
