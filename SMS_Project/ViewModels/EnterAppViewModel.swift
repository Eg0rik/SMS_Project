//
//  SendNumberViewModel.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation
import SwiftUI

enum EnterAppType {
    case signUp
    case logIn
}

final class EnterAppViewModel:ObservableObject {
    
    enum EnterAppStep {
        case sendNumber,verification,createPinCode,successPinCode
    }
    
    @Published var error:Error?
    @Published var enterAppStep = EnterAppStep.sendNumber
    @Published var enterAppType = EnterAppType.logIn
    
    private let network = NetworkService.shared
    
    func sendNumber(_ number:String,forType:EnterAppType) {
        
        switch forType {
            
            case .logIn:
                network.sendNumberForLogIn(number) { [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                        case .success:
                            enterAppStep = .verification
                        case .failure(let err):
                            error = err
                    }
                }
                
            case .signUp:
                network.sendNumberForSignUp(number) { [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                        case .success:
                            enterAppStep = .verification
                        case .failure(let err):
                            error = err
                    }
                }
        }
    }
    
    func checkSMSPin(_ pin:String) {
        
        network.checkPin(pin) { [weak self] result in
            guard let self else { return }
            
            switch result {
                case .success:
                    enterAppStep = .createPinCode
                case .failure(let err):
                    error = err
            }
        }
    }
}
