//
//  PinCodeService.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation

final class PinCodeService {
    
    static var shared = PinCodeService()
    private init() { }
    
    func setPinCode(_ pin:String) {
        UserDefaults.standard.setValue(pin, forKey: "pin")
    }
    
    func checkPinCode(_ pin:String) -> Bool {
        pin == UserDefaults.standard.string(forKey: "pin")
    }
    
    func deletePinCode() {
        UserDefaults.standard.removeObject(forKey: "pin")
    }
    
    func isPinCodeExists() -> Bool {
        UserDefaults.standard.string(forKey: "pin") != nil
    }
}
