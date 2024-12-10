//
//  HomeView.swift
//  PaymentApp
//
//  Created by Mohar on 08/12/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isLoggedIn: Bool
    @Binding var balance: Double
    @Binding var isBalanceHidden: Bool
    @ObservedObject var transactionData: TransactionData
    @Binding var showBottomSheet: Bool
    @Binding var bottomSheetMessage: String


    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Wallet Balance: ")
                Spacer()
                Text(isBalanceHidden ? "******" : "Rs \(balance, specifier: "%.2f")")
                Button(action: {
                    isBalanceHidden.toggle()
                }) {
                    Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                }
            }
            .padding()

            NavigationLink("Send Money") {
                SendMoneyView(balance: $balance, transactionData: transactionData, showBottomSheet: $showBottomSheet, bottomSheetMessage: $bottomSheetMessage)
            }
            .buttonStyle(.borderedProminent)

            NavigationLink("View Transactions") {
                TransactionsView(transactionData: transactionData)
            }
            .buttonStyle(.bordered)

            Spacer()

            Button("Logout") {
                isLoggedIn = false
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .sheet(isPresented: $showBottomSheet) {
            VStack {
                Text(bottomSheetMessage)
                    .font(.headline)
                    .padding()

                Button("Close") {
                    showBottomSheet = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

