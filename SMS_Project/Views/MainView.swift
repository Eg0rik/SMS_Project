//
//  MainView.swift
//  SMS_Project
//
//  Created by MAC on 6/9/24.
//

import Foundation
import SwiftUI

struct MainView:View {
    
    @EnvironmentObject var appService:AppService
    @EnvironmentObject var pinCodeVM:PinCodeViewModel
    
    var body: some View {
        ZStack {
            AppearanceData.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing:20) {
                customText("Добро пожаловать")
                customText("Вы успешно вошли")
                
                Button {
                    appService.logout()
                } label: {
                    Text("Выйти")
                        .modifier(CustomButtonModifier())
                }
                
                if pinCodeVM.isPinCodeExsist {
                    Button {
                        pinCodeVM.deletePinCode()
                    } label: {
                        Text("Удалить пид-код")
                            .modifier(CustomButtonModifier())
                    }
                }
            }
        }
    }
    
    @ViewBuilder func customText(_ txt:String) -> some View {
        Text(txt)
            .foregroundStyle(.white)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 5)
                    .fill(AppearanceData.linearGradient)
            )
    }
}

#Preview {
    ContentView()
}
