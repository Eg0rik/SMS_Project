//
//  CountryJSON.swift
//  SMS_Project
//
//  Created by MAC on 6/7/24.
//

import Foundation

struct Country:Identifiable,Codable {
    
    let id:Int
    let name:String
    let flag:String
    let dial_code:String
    
    static let countries:[Country] = Bundle.main.loadFrom("Contries.json")
    
    static func getCountry(id:Int) -> Country {
        countries.first(where: {$0.id == id}) ?? Country(id: 1, name: "Афганистан", flag: "🇦🇫", dial_code: "+93")
    }
}

extension Bundle {
    func loadFrom<T:Decodable>(_ file:String) -> T {
        guard
            let url = self.url(forResource: file, withExtension: nil),
            let data = try? Data(contentsOf: url),
            let loaded = try? JSONDecoder().decode(T.self, from: data) 
        else {
            fatalError("Failed to load contries from JSON")
        }
        
        return loaded
    }
}
