import UIKit
import Eureka

class TransactionsViewController: FormViewController {

    var user: User?
    var recivedUserName: String?
    var recivedPassword: String?
    var recivedEmail: String?
    var recivedBalance: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpNavigationBar()
        setupForm()
        fetchUserData()
    }

    func fetchUserData() {
        // Replace the URL string with your actual backend endpoint
        let urlString = "https://coded-bank-api.eapi.joincoded.com/account"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        // Create a URLSession data task to fetch user data
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            // Decode the data into your User model or use a JSONDecoder
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)

                NetworkManager.shared.signup(user: user) { response in
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        
                        switch response {
                            
                        case .success(let tokenResponse):
                            print(tokenResponse.token)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }


    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        title = "Transactions"
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupForm() {
        form  +++ Section("Balance")

        <<< DecimalRow("balanceRow") {
            $0.title = "Balance"
            $0.value = recivedBalance
            $0.disabled = true
        }
        
        +++ Section("Operations")
            <<< ButtonRow("Deposit") {
                $0.title = "Deposit"
            }.onCellSelection { _, _ in
                self.presentInputDialog(title: "Deposit", message: "Enter amount to deposit", placeholder: "Amount") { amount in
                    if let amount = amount, let depositAmount = Double(amount) {
                        self.recivedBalance += depositAmount
                        self.updateBalanceRow()
                    }
                }
            }

            <<< ButtonRow("Withdraw") {
                $0.title = "Withdraw"
            }.onCellSelection { _, _ in
                self.presentInputDialog(title: "Withdraw", message: "Enter amount to withdraw", placeholder: "Amount") { amount in
                    if let amount = amount, let withdrawAmount = Double(amount) {
                        if withdrawAmount <= self.recivedBalance {
                            self.recivedBalance -= withdrawAmount
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
            textField.keyboardType = .decimalPad
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
        guard let row: DecimalRow = form.rowBy(tag: "balanceRow") else { return }
        row.value = recivedBalance
        row.updateCell()
    }

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
