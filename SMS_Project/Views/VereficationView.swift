//
//  VereficationView.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation
import SwiftUI

struct VereficationView:View {
    
    @EnvironmentObject var enterAppVM:EnterAppViewModel
    @EnvironmentObject var appService:AppService
    
    @State var pin:String = ""
    @State var showButtonSendAgain = false
    
    @State private var remainingTime = 300
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let buttonTitle:String
    let enterType:EnterAppType
    
    init(enterType:EnterAppType) {
        self.enterType = enterType
        
        switch enterType {
            case .logIn:
                buttonTitle = "Войти"
            case .signUp:
                buttonTitle = "Зарегистрироваться"
        }
    }
    
    var body: some View {
        
        VStack {
            
            Text("Верефикация")
                .foregroundStyle(.white)
                .font(.title2)
                .padding(.top,20)
            
            Text("""
                Введите код из смс,
                что мы вам отправили
                """
            )
            .frame(height: 75)
            .padding(.top,15)
            .foregroundStyle(.gray)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            
            if showButtonSendAgain {
                Button {
                    showButtonSendAgain = false
                } label: {
                    VStack {
                        Text("Отправить код еще раз")
                        Rectangle()
                            .frame(height: 2)
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundStyle(.blue)
                }
            }
            else {
                Text("""
             Запросить код можно через
             через \(timeInMinutes(remainingTime))
             """)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .onReceive(timer) {_ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        showButtonSendAgain = true
                    }
                }
            }
            
            PinTextField(pin: $pin)
                .padding(20)
            
            //MARK: sending a pin
            Button {
                if pin.count == 6 {
                    enterAppVM.checkSMSPin(pin)
                    
                    if enterType == .logIn {
                        appService.authorizeUser()
                    }
                }
            } label: {
                Text(buttonTitle)
                    .modifier(CustomButtonModifier(disable: pin.count != 6))
            }
            
            
            NavigationLink(destination: NoSendCodeView()) {
                VStack(spacing:0) {
                    Text("Я не получил код!")
                    Rectangle()
                        .frame(height: 1)
                }
                .foregroundStyle(.white)
                .fixedSize(horizontal: true, vertical: false)
                .font(.footnote)
                .padding(.top)
            }
            
            Spacer()
        }
    }
    
    func timeInMinutes(_ seconds:Int) -> String {
        let min = seconds / 60
        let remainseconds = seconds % 60
        
        var minStr = String(min)
        if min / 10 == 0 {
            minStr = "0" + minStr
        }
        var secondsString = String(remainseconds)
        if remainseconds / 10 == 0 {
            secondsString = "0" + secondsString
        }
        
        return "\(minStr):\(secondsString)"
    }
}

struct PinTextField:View {
    
    enum PinNumber:Int, CaseIterable {
        case one = 1,two,three,four,five,six
    }

    @Binding var pin:String
    
    @State var pinSymbols = Array(repeating: "", count: 6)
    @FocusState var focusPinNumber:PinNumber?
    
    var body: some View {
        HStack {
            ForEach(PinNumber.allCases,id: \.self) { pinNumber in
                TextField("",text: $pinSymbols[pinNumber.rawValue - 1])
                    .focused($focusPinNumber,equals: pinNumber)
                    //logic
                    .onChange(of: pinSymbols[pinNumber.rawValue - 1]) { oldValue, newValue in
                        
                        if newValue.count > 1 {
                            pinSymbols[pinNumber.rawValue - 1] = oldValue
                        }
                        
                        if newValue.count == 1 {
                            focusPinNumber = PinNumber(rawValue: pinNumber.rawValue + 1)
                        }
                        
                        gatherPin()
                    }
                    //appearance
                    .frame(width:50,height:50)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .modifier(CustomBorderModifier(cornerRadius: 3,padding:0))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    func gatherPin() {
        pin = pinSymbols.joined()
    }
}

#Preview {
    NavigationStack {
        EnterAppView(type: .logIn)
    }
}
