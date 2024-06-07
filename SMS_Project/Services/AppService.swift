//
//  AppService.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation
import SwiftUI

final class AppService:ObservableObject {
    
    @Published var isAuthenticated = false
    
    func checkIsAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "token") != nil
    }
    
    func login(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        isAuthenticated = true
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        isAuthenticated = false
    }
    
    func authorizeUser() {
        let network = NetworkService.shared
        
        let token = UUID().uuidString
        
        network.authorizeUser(with: token) { [weak self] result in
            guard let self else { return }
            
            switch result {
                case .success:
                    UserDefaults.standard.set(token, forKey: "token")
                    isAuthenticated = true
                case .failure:
                    isAuthenticated = false
            }
        }
    }
}
