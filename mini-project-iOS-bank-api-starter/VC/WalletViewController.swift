//
//  WalletViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Saleh Bin Essa on 06/03/2024.
//

import UIKit

import Eureka

class WalletTableViewController: FormViewController {

    private var balance: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }

    private func setupForm() {
        form +++ Section("Balance") <<< LabelRow() {
            $0.title = "Current Balance"
            $0.value = "\(balance)"
        }

        +++ Section("Operations")
        <<< ButtonRow("Deposit") {
            $0.title = "Deposit"
            }.onCellSelection { _, _ in
                self.presentInputDialog(title: "Deposit", message: "Enter amount to deposit", placeholder: "Amount") { amount in
                    if let amount = amount, let depositAmount = Int(amount) {
                        self.balance += depositAmount
                        self.updateBalanceRow()
                    }
                }
            }

        <<< ButtonRow("Withdraw") {
            $0.title = "Withdraw"
            }.onCellSelection { _, _ in
                self.presentInputDialog(title: "Withdraw", message: "Enter amount to withdraw", placeholder: "Amount") { amount in
                    if let amount = amount, let withdrawAmount = Int(amount) {
                        if withdrawAmount <= self.balance {
                            self.balance -= withdrawAmount
                            self.updateBalanceRow()
                        } else {
                            self.presentAlert(title: "Error", message: "Insufficient funds")
                        }
                    }
                }
            }
    }

    private func presentInputDialog(title: String, message: String, placeholder: String, completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = placeholder
            textField.keyboardType = .numberPad
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let amount = alertController.textFields?.first?.text else {
                completion(nil)
                return
            }
            completion(amount)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)

        present(alertController, animated: true, completion: nil)
    }

    private func updateBalanceRow() {
        let balanceRow: LabelRow? = form.rowBy(tag: "Current Balance")
        balanceRow?.value = "\(balance)"
        balanceRow?.updateCell()
    }

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

