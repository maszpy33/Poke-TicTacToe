//
//  ButtonStyles.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 18.06.22.
//

import Foundation
import SwiftUI


struct DefaultButton: ButtonStyle {
    
    var buttonWidth: CGFloat
    var themeColorPrimary: Color
    var themeColorSecondary: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonWidth)
            .padding()
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.black)
            .background(LinearGradient(colors: [themeColorPrimary, themeColorSecondary], startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding(.bottom, 30)
    }
}
