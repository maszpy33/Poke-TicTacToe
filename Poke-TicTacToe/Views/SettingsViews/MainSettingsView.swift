//
//  MainSettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct MainSettingsView: View {
    
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    @State private var pickerViewSwitch: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                CustomToggleSwitch(pickerViewSwitch: $pickerViewSwitch, leftButtonText: "Settings", rightButtonText: "ScoreBoard", buttonColor: gsvm.changeThemeColor(themeColor: "purple"))
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .offset(x: 5)
                
                Spacer()
                
                if !pickerViewSwitch {
                    SettingsView()
                        .environmentObject(gvm)
                        .environmentObject(gsvm)
                } else {
                    ScoreBoardView()
                        .environmentObject(gvm)
                        .environmentObject(gsvm)
                }
                
                Spacer()
            }
            .navigationTitle("Main Settings:")
        }
    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsView()
    }
}
