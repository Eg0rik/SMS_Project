//
//  PinCodeView.swift
//  SMS_Project
//
//  Created by MAC on 6/9/24.
//

import Foundation
import SwiftUI

struct CreatePinCodeView:View {
    
    @EnvironmentObject var pinCodeVM:PinCodeViewModel
    @EnvironmentObject var enterAppVM:EnterAppViewModel
    @EnvironmentObject var appService:AppService
    
    @State var pin = ""
    
    @FocusState var textFieldFocus:Bool
    
    var body: some View {
        
        ZStack {
            
            AppearanceData.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                Text("Создайте код приложения")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.bottom, 30)
                    .padding(.top,155)
                
                Text("Введите код из символов")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 30)
                
                PasswordTextField(pin: $pin, isInvalidPin: .constant(false),textFieldFocus: $textFieldFocus)
                    .onChange(of: pin) { _, newValue in
                        if newValue.count == 4 {
                            textFieldFocus = false
                        }
                    }
                    .padding(.bottom,70)
                
                Button {
                    if pin.count == 4 {
                        pinCodeVM.setPin(pin)
                        enterAppVM.enterAppStep = .successPinCode
                    }
                } label: {
                    Text("Создать код")
                        .modifier(CustomButtonModifier())
                }
                
                Spacer()
            }
        }
    }
}

struct EnterWithPinCodeView:View {
    
    @EnvironmentObject var pinCodeVM:PinCodeViewModel
    @EnvironmentObject var appService:AppService
    
    @State var pin = ""
    @State var isInvalidPin = false
    
    @FocusState var textFieldFocus:Bool
    
    var body: some View {
        
        ZStack {
            
            AppearanceData.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                Text("Введите код из символов")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.bottom, 30)
                    .padding(.top,155)
                
                VStack {
                    PasswordTextField(pin: $pin,isInvalidPin: $isInvalidPin, textFieldFocus: $textFieldFocus)
                        .onChange(of: pin) { _, newValue in
                            if newValue.count == 4 {
                                textFieldFocus = false
                            }
                            isInvalidPin = false
                        }
                    
                    if isInvalidPin {
                        Text("Неверный код")
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                }
                .frame(height: 200)

                Button {
                    guard pin.count == 4 else { return }
                    guard pinCodeVM.checkPinCode(pin) else {
                        isInvalidPin = true
                        return
                    }
                    
                    appService.authorizeUser()
                } label: {
                    Text("Войти")
                        .modifier(CustomButtonModifier())
                }
                Spacer()
                Spacer()
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

struct SuccessPinCode:View {
    
    @EnvironmentObject var appService:AppService
    
    var body: some View {
        ZStack {
            AppearanceData.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing:25) {
                Text("""
                Вы успешно создали код
                приложения
                """)
                .multilineTextAlignment(.center)
                .frame(width:300,height: 140)
                .background(RoundedRectangle(cornerRadius: 25).fill(.gray.opacity(0.2)))
                .foregroundStyle(.white)
                
                Button {
                    appService.authorizeUser()
                } label: {
                    Text("Войти в приложение")
                        .frame(width:300,height: 75)
                        .background(RoundedRectangle(cornerRadius: 25).fill(.gray.opacity(0.2)))
                }
                .foregroundStyle(.blue)
            }
        }
    }
}

struct PasswordTextField:View {
    
    @Binding var pin:String
    @Binding var isInvalidPin:Bool
    var textFieldFocus: FocusState<Bool>.Binding
    
    var body: some View {
        ZStack {
            
            HStack(spacing:25) {
                ForEach(0..<4) { index in
                    customCircle(index: index)
                }
            }
            .frame(width:170,height: 70)
            .background(
                Capsule().fill(.gray.opacity(0.2))
            )
            .overlay {
                if textFieldFocus.wrappedValue {
                    Capsule()
                        .stroke(lineWidth: 2)
                        .fill(AppearanceData.linearGradient.opacity(0.7))
                }
                
                if isInvalidPin {
                    Capsule()
                        .stroke(lineWidth: 2)
                        .fill(.red)
                }
            }
            SecureField("", text: $pin)
                .frame(width: 1,height: 1)
                .keyboardType(.numberPad)
                .focused(textFieldFocus)
                .opacity(0)
        }
        .onTapGesture {
            textFieldFocus.wrappedValue.toggle()
        }
    }
    
    func customCircle(index:Int) -> some View {
        Circle()
            .frame(height: 10)
            .foregroundStyle(pin.count > index ? AnyShapeStyle(AppearanceData.linearGradient) : AnyShapeStyle(.gray.opacity(0.7)))
    }
}

#Preview {
    EnterWithPinCodeView()
        .environmentObject(PinCodeViewModel())
        .environmentObject(AppService())
}
