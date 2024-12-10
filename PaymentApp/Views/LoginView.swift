//
//  LoginView.swift
//  PaymentApp
//
//  Created by Mohar on 08/12/24.
//

import SwiftUI

// MARK: - LoginView
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Binding var isLoggedIn: Bool

    var body: some View {

        VStack(spacing: 20) {
            Image(systemName: "indianrupeesign.ring").font(.system(size: 100)).foregroundColor(.green)
            Text("Login").font(.title).bold()
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)

            }

            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: {
                    viewModel.login {
                        isLoggedIn = viewModel.isLoggedIn
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }

        }
        .padding()
    }
}

#Preview {
    @Previewable @State var isLoggedIn = false
    LoginView(isLoggedIn: $isLoggedIn)
}
