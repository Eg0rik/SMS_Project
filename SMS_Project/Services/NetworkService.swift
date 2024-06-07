//
//  NetworkService.swift
//  SMS_Project
//
//  Created by MAC on 6/8/24.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    func sendNumberForLogIn(_ number:String, completion: @escaping (Result<Bool,Error>) -> ()) {
        //sending number to backend
        completion(.success(true))
    }
    
    func sendNumberForSignUp(_ number:String, completion: @escaping (Result<Bool,Error>) -> ()) {
        //sending number to backend
        completion(.success(true))
    }
    
    func checkPin(_ pin:String,completion: @escaping (Result<Bool,Error>) -> ()) {
        //send wrote pin and check is it right
        completion(.success(true))
    }
    
    func authorizeUser(with token:String,completion: @escaping (Result<Bool,Error>) -> ()) {
        //ask backend: Can we authorized User?
        completion(.success(true))
    }
}
