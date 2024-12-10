//
//  LoginData.swift
//  PaymentApp
//
//  Created by Mohar on 10/12/24.
//

import Foundation

// MARK: - LoginData

// Data model for Login api response
struct LoginData: Codable {
    let accessToken, refreshToken: String
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
}
