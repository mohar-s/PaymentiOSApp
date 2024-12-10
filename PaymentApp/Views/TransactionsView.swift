//
//  TransactionsView.swift
//  PaymentApp
//
//  Created by Mohar on 08/12/24.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionData: TransactionData

    var body: some View {
        VStack(spacing: 20) {
            Text("Transaction History")
                .font(.headline)

            List(transactionData.transactions) { transaction in
                VStack(alignment: .leading) {
                    Text("Sent Rs \(transaction.amount, specifier: "%.2f")")
                    Text("Reciver : \(transaction.name)")
                    Text(transaction.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    // added single default to see the Preview
    @Previewable @State var transactionData = TransactionData()
    TransactionsView(transactionData: transactionData)
}
