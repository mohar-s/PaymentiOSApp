//
//  PaymentAppTests.swift
//  PaymentAppTests
//
//  Created by Mohar on 08/12/24.
//

import XCTest
@testable import PaymentApp

final class PaymentAppTests: XCTestCase {

    func testLoginSuccess() {
           let username = "user"
           let password = "password"
           XCTAssertTrue(validateLogin(username: username, password: password), "Login should succeed with correct username and password.")
       }

       func testLoginFailure() {
           let username = "wrongUser"
           let password = "wrongPassword"
           XCTAssertFalse(validateLogin(username: username, password: password), "Login should fail with incorrect username and password.")
       }

       func testBalanceVisibilityToggle() {
           var isBalanceHidden = false
           isBalanceHidden.toggle()
           XCTAssertTrue(isBalanceHidden, "Balance visibility should toggle to hidden.")
           isBalanceHidden.toggle()
           XCTAssertFalse(isBalanceHidden, "Balance visibility should toggle back to visible.")
       }

       func testSendMoneySuccess() {
           let initialBalance = 500.0
           let amountToSend = 100.0
           var balance = initialBalance
           let result = sendMoney(amount: amountToSend, balance: &balance)
           XCTAssertTrue(result.success, "Transaction should succeed with valid amount.")
           XCTAssertEqual(balance, 400.0, "Balance should be reduced correctly after sending money.")
       }

       func testSendMoneyFailureDueToInsufficientBalance() {
           let initialBalance = 500.0
           let amountToSend = 600.0
           var balance = initialBalance
           let result = sendMoney(amount: amountToSend, balance: &balance)
           XCTAssertFalse(result.success, "Transaction should fail due to insufficient balance.")
           XCTAssertEqual(balance, 500.0, "Balance should remain unchanged after failed transaction.")
       }

       func testSendMoneyFailureDueToInvalidAmount() {
           let initialBalance = 500.0
           let amountToSend = -100.0
           var balance = initialBalance
           let result = sendMoney(amount: amountToSend, balance: &balance)
           XCTAssertFalse(result.success, "Transaction should fail with invalid amount.")
           XCTAssertEqual(balance, 500.0, "Balance should remain unchanged after failed transaction.")
       }

       func testAddTransaction() {
           let transactionData = TransactionData()
           XCTAssertEqual(transactionData.transactions.count, 0, "Initial transaction count should be 0.")
           transactionData.addTransaction(amount: 100.0)
           XCTAssertEqual(transactionData.transactions.count, 1, "Transaction count should increase after adding a transaction.")
           XCTAssertEqual(transactionData.transactions.first?.amount, 100.0, "Transaction amount should match the added amount.")
       }

       func testTransactionHistory() {
           let transactionData = TransactionData()
           transactionData.addTransaction(amount: 100.0)
           transactionData.addTransaction(amount: 200.0)
           XCTAssertEqual(transactionData.transactions.count, 2, "Transaction history should contain all added transactions.")
           XCTAssertEqual(transactionData.transactions[0].amount, 100.0, "First transaction amount should match.")
           XCTAssertEqual(transactionData.transactions[1].amount, 200.0, "Second transaction amount should match.")
       }

       // Helper functions for testing
       private func validateLogin(username: String, password: String) -> Bool {
           return username == "user" && password == "password"
       }

       private func sendMoney(amount: Double, balance: inout Double) -> (success: Bool, message: String) {
           guard amount > 0 else { return (false, "Invalid amount.") }
           guard amount <= balance else { return (false, "Insufficient balance.") }
           balance -= amount
           return (true, "Transaction successful.")
       }
    
}
