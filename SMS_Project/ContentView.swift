//
//  ContentView.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var pincodeVM = PinCodeViewModel()
    @StateObject var appService = AppService()
    
    var body: some View {
        
        VStack {
            if appService.isAuthenticated {
                MainView()
            } 
            else {
                NavigationStack {
                    ScreenSaver(isPinCodeExist: pincodeVM.isPinCodeExsist)
                }
            }
        }
        .environmentObject(appService)
        .environmentObject(pincodeVM)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
