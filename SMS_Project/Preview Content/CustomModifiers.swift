//
//  CustomModifiers.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import Foundation
import SwiftUI
import Combine

struct CustomButtonModifier: ViewModifier {
    let disable: Bool
    
    init(disable:Bool = false) {
        self.disable = disable
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: 340,height: 60)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(disable ? AnyShapeStyle(.gray) : AnyShapeStyle(AppearanceData.linearGradient))
                    .disabled(disable)
            )
            .contentShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct CustomBorderModifier: ViewModifier {
    let cornerRadius: CGFloat
    let padding: CGFloat
    
    init(cornerRadius:CGFloat = 6,padding:CGFloat = 15) {
        self.cornerRadius = cornerRadius
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
                    .fill(AppearanceData.linearGradient)
            }
            .padding(0.5)
    }
}
