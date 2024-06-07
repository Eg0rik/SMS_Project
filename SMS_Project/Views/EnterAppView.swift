//
//  GetCodeView.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import Foundation
import SwiftUI

struct EnterAppView:View {
    
    @StateObject var enterAppVM = EnterAppViewModel()
    @State var enterType:EnterAppType = .logIn
    @State var navigationTitle:String //and Button title
    
    init(type:EnterAppType) {
        
        enterType = type
        
        switch type {
            case .signUp:
                navigationTitle = "Зарегистрироваться"
            case .logIn:
                navigationTitle = "Войти"
        }
    }
    
    var body: some View {
        
        ZStack {
            AppearanceData.backgroundColor
                .ignoresSafeArea()
            
            switch enterAppVM.enterAppStep {
                    
                case .sendNumber:
                    SendNumberView(enterType: $enterType)
                        .padding(.top,20)
                        
                case .verification:
                    VereficationView(enterType: enterType)
                    
                case .createPinCode:
                    CreatePinCodeView()
                        .onAppear {
                            navigationTitle = "Код приложения"
                        }
                    
                case .successPinCode:
                    SuccessPinCode()
            }
        }
        .environmentObject(enterAppVM)
        .foregroundStyle(.white)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(navigationTitle)
                    .foregroundStyle(.white)
                    .font(.title2)
            }
            ToolbarItem(placement:.topBarLeading) {
              BackButton()
            }
        }
    }
}

struct BackButton : View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ContentView()
}
