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
    @State private var name: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text("Send Money").font(.title2).padding()
            TextField("Enter Reciver Name", text: $name, onEditingChanged: { changed in
                errorMessage = ""
            })
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            TextField("Enter Amount", text: $amount)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Submit") {
                if name.isEmpty && amount.isEmpty {  // Check the Reciver name and amount both
                    errorMessage = "Please Enter Reciver Name and Amount!"
                    return
                }
               
                if name.isEmpty {  // Check the Reciver name
                    errorMessage = "Please Enter Reciver Name!"
                    return
                }
                if amount.isEmpty { // check the Entered amount
                    errorMessage = "Please Enter Amount!"
                    return
                }
                errorMessage = ""
                if let amountDouble = Double(amount), amountDouble > 0, amountDouble <= balance {
                    balance -= amountDouble
                    transactionData.addTransaction(name: name, amount: amountDouble)
                    bottomSheetMessage = "Transaction Successful!"
                } else {
                    bottomSheetMessage = "Transaction Failed!"
                }
                showBottomSheet = true
                amount = ""
            }
            .buttonStyle(.borderedProminent)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)

            }

            Spacer()
            Spacer()
        }
        .padding()
    }
}


#Preview {
    
    // added single entery to see the Preview
    @Previewable @State var balance = 200.0
    @Previewable @State var showBottomSheet: Bool = false
    @Previewable @State var bottomSheetMessage: String = "test"
    @Previewable @State var transactionData = TransactionData()
    SendMoneyView(balance: $balance, transactionData: transactionData, showBottomSheet: $showBottomSheet, bottomSheetMessage: $bottomSheetMessage)
}
