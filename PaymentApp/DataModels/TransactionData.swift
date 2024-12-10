//
//  TransactionData.swift
//  PaymentApp
//
//  Created by Mohar on 10/12/24.
//


import SwiftUI

// Store user's trasaction
class TransactionData: ObservableObject {
    @Published var transactions: [Transaction] = []  // upadate the UI as soon as new entry added

    // create the trasaction record
    func addTransaction( name : String, amount: Double) {
        let newTransaction = Transaction(id: UUID(), amount: amount, date: Date() , name: name)
        transactions.append(newTransaction)
    }
}

// Entity/Model for signle trasaction
struct Transaction: Identifiable {
    let id: UUID
    let amount: Double
    let date: Date
    let name: String
}
