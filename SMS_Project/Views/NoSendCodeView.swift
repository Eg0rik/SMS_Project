//
//  NoSendView.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation
import SwiftUI

struct NoSendCodeView : View {

    var body: some View {
        ZStack {
            AppearanceData.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Не пришел код?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.bottom, 25)
                Text("""
                     Обратитесь в чат
                     поддержки
                     """)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.bottom, 180)
                
                Button("Перейти в чат поддержки") {
                    
                }
                .modifier(CustomButtonModifier())
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
    }
}
