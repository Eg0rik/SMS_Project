//
//  ScreenSaver.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import SwiftUI

struct ScreenSaver: View {
    
    var title = "SIS"
    var subTitle = "Выбери свою безопасность"
    var buttonEnterTitle:String
    var question = "У вас нет аккаунта?"
    var buttonSignUpTitle = "Зарегестрируйтесь сейчас"
    
    @EnvironmentObject var pinCodeVM:PinCodeViewModel
    
    init(isPinCodeExist:Bool) {
        buttonEnterTitle = isPinCodeExist ? "Войти по коду" : "Войти по номеру телефона"
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                AppearanceData.backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing:20) {
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100)
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                            
                    Text(subTitle)
                        .font(.title2)
                        .padding(.bottom,60)
                    
                    //MARK: LogIn button
                    NavigationLink {
                        
                        if pinCodeVM.isPinCodeExsist {
                            EnterWithPinCodeView()
                        } else {
                            EnterAppView(type: .logIn)
                        }
                        
                    } label: {
                        Text(buttonEnterTitle)
                            .modifier(CustomButtonModifier())
                    }
                    .padding(.bottom,100)
                    
                    VStack {
                        Text(question)
                        //MARK: SignUp button
                        NavigationLink(destination: EnterAppView(type: .signUp)) {
                            
                            VStack(spacing:0) {
                                Text(buttonSignUpTitle)
                                   
                                Rectangle()
                                    .frame(height: 1)
                            }
                            .foregroundStyle(.blue)
                            .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                    .padding(.bottom,50)
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
