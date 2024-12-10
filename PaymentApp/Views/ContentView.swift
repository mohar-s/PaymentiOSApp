//
//  ContentView.swift
//  PaymentApp
//
//  Created by Mohar on 08/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var balance: Double = 500.00
    @State private var isBalanceHidden = false
    @State private var showBottomSheet = false
    @State private var bottomSheetMessage = ""

    @StateObject private var transactionData = TransactionData()

    var body: some View {
        NavigationView {
            // check the users login status 
            if isLoggedIn {
                HomeView(
                    isLoggedIn: $isLoggedIn,
                    balance: $balance,
                    isBalanceHidden: $isBalanceHidden,
                    transactionData: transactionData,
                    showBottomSheet: $showBottomSheet,
                    bottomSheetMessage: $bottomSheetMessage
                )
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

#Preview {
    ContentView()
}
