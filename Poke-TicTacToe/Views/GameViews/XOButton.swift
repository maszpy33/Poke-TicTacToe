//
//  XOButton.swift
//  TicTacToe-CatEdition
//
//  Created by Andreas Zwikirsch on 03.05.22.
//

import SwiftUI


struct XOButton: View {
    @EnvironmentObject var gvm: GameViewModel
    @EnvironmentObject var gsvm: GameScoreViewModel
    
    @Binding var letter: String
    @State private var degrees = 0.0
    @State private var playerImage: Image = Image(systemName: "questionmark")
    
    @State private var isTapped: Bool = false
    
    @Binding var isOccupied: Bool
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
//                .mask(RoundedRectangle(cornerRadius: 15)
//                    .frame(width: 120, height: 120))
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 120, height: 120)
                .foregroundColor(.accentColor)
//                .foregroundColor(Color(red: 0.30, green: 0.8, blue: 0.56))
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 100, height: 100)
                .foregroundColor(.black)

            if letter == "" {
                Text(letter)
                    .font(.system(size: 50))
                    .bold()
            } else {
                gvm.getPlayerImage(letter: letter)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    if !gvm.gameEnded {
                        if letter == "X" {
                            playerImage = gvm.playerOneImage
                        } else if letter == "O" {
                            playerImage = gvm.playerTwoImage
                        }
                        
                        withAnimation(.easeIn(duration: 0.25)) {
                            self.degrees -= 180
                        }
                    }
                }
        )
        .onAppear {
            if letter.isEmpty {
                playerImage = gvm.getPlayerImage(letter: letter)
                isOccupied = false
            }
        }
        .accentColor(gsvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
    }
}

//struct XOButton_Previews: PreviewProvider {
//    static var previews: some View {
//        XOButton()
//    }
//}
