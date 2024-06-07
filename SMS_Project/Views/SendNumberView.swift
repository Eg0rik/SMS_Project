//
//  SendNumberView.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation
import SwiftUI

struct SendNumberView:View {
    
    let numbersRequired = 7
    var subTitle = "Код придет на ваш номер телефона"
    var buttonTitle = "Получить код"
    
    @State var number = ""
    @State var selectedCountryID = 1
    @FocusState private var numberTextFocus: Bool
    
    @Binding var enterType:EnterAppType
    
    @EnvironmentObject var enterAppVM:EnterAppViewModel
    
    var body: some View {
        
        VStack {
            
            VStack {
                VStack(alignment: .leading) {
                    
                    Text("Номер телефона")
                        .font(.footnote)
                        .padding(.leading,5)
                    
                    HStack {
                        CountryPicker(selectedCountryID: $selectedCountryID)
                        
                        TextField("", text: $number)
                            .focused($numberTextFocus)
                            .keyboardType(.numberPad)
                            .modifier(CustomBorderModifier())
                    }
                    .padding(5)
                }
                
                Text(subTitle)
                    .padding(.top,10)
                    .padding(.bottom,30)
            }
            .padding(.vertical,15)
            
            //MARK: sendig number
            Button {
                if numbersRequired == number.count {
                    numberTextFocus = false
                    enterAppVM.sendNumber(number, forType: enterType)
                }
            } label: {
                Text(buttonTitle)
                    .modifier(CustomButtonModifier(disable: numbersRequired != number.count))
            }
            
            Spacer()
        }
    }
}

struct CountryPicker:View {
    
    @Binding var selectedCountryID:Int
    
    var countryNumber:String {
        Country.getCountry(id: selectedCountryID).dial_code
    }
    
    var body: some View {
        
        Menu {
            Picker("", selection:$selectedCountryID) {
                ForEach(Country.countries) { country in
                    Text(country.flag + " " + country.name + " " + country.dial_code)
                        .tag(country.id)
                }
                
            }
            
        } label: {
            HStack {
                Text(countryNumber)
                Image(systemName: "chevron.down")
            }
            .foregroundStyle(.white)
            .modifier(CustomBorderModifier())
        }
    }
}

#Preview {
    ContentView()
}
