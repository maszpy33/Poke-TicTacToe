//
//  MainSettingsView.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 28.06.22.
//

import SwiftUI

struct MainSettingsView: View {
    
    @EnvironmentObject var gsvm: GameScoreViewModel
    @State private var pickerViewSwitch: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                CustomToggleSwitch(pickerViewSwitch: $pickerViewSwitch, leftButtonText: "Settings", rightButtonText: "ScoreBoard")
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .offset(x: 5)
                
                Spacer()
                
                if !pickerViewSwitch {
                    SettingsView()
                        .environmentObject(gsvm)
                } else {
                    ScoreBoardView()
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
