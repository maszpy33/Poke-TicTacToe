//
//  CustomToggleSwitch.swift
//  Poke-TicTacToe
//
//  Created by Andreas Zwikirsch on 26.06.22.
//

import SwiftUI

struct CustomToggleSwitch: View {
    
    @EnvironmentObject var gvm: GameViewModel
    
    @Binding var pickerViewSwitch: Bool
    @State private var width: CGFloat = 140
    @State private var height: CGFloat = 40
    @State private var switchWidth: CGFloat = 0.0
    
    @State var leftButtonText: String
    @State var rightButtonText: String
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    if pickerViewSwitch {
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .opacity(0)
                        .padding()
                        .frame(width: width, height: height)
//                        .background(Color.accentColor.opacity(0.2))
                        .background(gvm.changeThemeColor(themeColor: gvm.themeColorPrimary))
                        .cornerRadius(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.accentColor, lineWidth: 2))
                        .cornerRadius(10)
                        .padding(.trailing, pickerViewSwitch ? 10 : 0)
                        
                    if !pickerViewSwitch {
                        Spacer()
                    }
                }
//                .padding(.horizontal, 15)
                
                HStack {
                    Text(leftButtonText)
                        .multilineTextAlignment(.center)
                        .frame(width: width)
                    Spacer()
                    Text(rightButtonText)
                        .multilineTextAlignment(.center)
                        .frame(width: width)
                        .padding(.trailing, 10)
                }
                .font(.system(size: 20, weight: .semibold))

            }
            .onTapGesture {
                withAnimation(.spring(response: 0.5)) {
                    pickerViewSwitch.toggle()
                }
            }
            .onAppear {
                switchWidth = height
            }
        }

    }
}

//struct CustomToggleSwitch_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomToggleSwitch()
//    }
//}
