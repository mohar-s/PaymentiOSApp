//
//  SendMoneyView.swift
//  PaymentApp
//
//  Created by Mohar on 08/12/24.
//

import SwiftUI

struct SendMoneyView: View {
    @Binding var balance: Double
    @ObservedObject var transactionData: TransactionData
    @Binding var showBottomSheet: Bool
    @Binding var bottomSheetMessage: String

    @State private var amount: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text("Send Money").font(.title2).padding()
            TextField("Enter Amount", text: $amount)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Submit") {
                if let amountDouble = Double(amount), amountDouble > 0, amountDouble <= balance {
                    balance -= amountDouble
                    transactionData.addTransaction(amount: amountDouble)
                    bottomSheetMessage = "Transaction Successful!"
                } else {
                    bottomSheetMessage = "Transaction Failed!"
                }
                showBottomSheet = true
                amount = ""
            }
            .buttonStyle(.borderedProminent)

            Spacer()
            Spacer()
        }
        .padding()
    }
}


#Preview {
    @Previewable @State var balance = 200.0
    @Previewable @State var showBottomSheet: Bool = false
    @Previewable @State var bottomSheetMessage: String = "test"
    @Previewable @State var transactionData = TransactionData()
    SendMoneyView(balance: $balance, transactionData: transactionData, showBottomSheet: $showBottomSheet, bottomSheetMessage: $bottomSheetMessage)
}
