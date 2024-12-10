//
//  LoginViewModel.swift
//  PaymentApp
//
//  Created by Mohar on 09/12/24.
//

import SwiftUI

// MARK: - LoginViewModel

// Create the Login view model for all bussiness logic
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String? = nil

    // Call login api
    func login(completion: @escaping () -> ()) {
        guard !username.isEmpty && !password.isEmpty else {
            errorMessage = "Please enter username and password."
            return
        }

        isLoading = true
        errorMessage = nil
        
        // API call
        let loginUrl = "https://dummyjson.com/auth/login" // use dummy url for login
        LoginService().callLoginAPI(from: loginUrl, username: username, password: password) { login in
            DispatchQueue.main.async {  // run the code on main to update the UI
                self.isLoading = false
                if let _ = login {
                    self.isLoggedIn = true
                } else {
                    self.errorMessage = "Invalid credentials."
                }
                
                completion()
            }
        }
    }
}
