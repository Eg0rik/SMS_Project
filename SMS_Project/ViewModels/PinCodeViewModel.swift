//
//  PinCodeViewModel.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation

final class PinCodeViewModel:ObservableObject {
    
    private let pinCodeService = PinCodeService.shared
    private let networkService = NetworkService.shared
    
    @Published var isPinCodeExsist:Bool
    @Published var isPinCodeIntroduced:Bool
    
    init() {
        isPinCodeExsist = pinCodeService.isPinCodeExists()
        isPinCodeIntroduced = false
    }
    
    func deletePinCode() {
        pinCodeService.deletePinCode()
        isPinCodeExsist = false
    }
    
    func checkIsPinCodeExists() {
        isPinCodeExsist = pinCodeService.isPinCodeExists()
    }
    
    func setPin(_ pin:String) {
        pinCodeService.setPinCode(pin)
        isPinCodeExsist = true
    }
    
    func checkPinCode(_ pin:String) -> Bool {
        guard pinCodeService.checkPinCode(pin) else { return false}
        
        return true
    }
}
