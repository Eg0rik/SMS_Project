//
//  Appearance.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import Foundation
import SwiftUI

final class AppearanceData {
    private init() { }
    
    static let backgroundColor = Color("backgroundColor")
    
    static let linearGradient = LinearGradient(
        colors: [
            Color("endGradientColor"),
            Color("startGradientColor")
        ],
        startPoint: UnitPoint(x: 0.4, y: 1),
        endPoint: UnitPoint(x: 0.5, y: 0)
    )
}
