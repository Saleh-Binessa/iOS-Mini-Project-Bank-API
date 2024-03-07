//
//  SignUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Saleh Bin Essa on 06/03/2024.
//

import Foundation
import Eureka
import UIKit
import Alamofire
import Kingfisher
import SnapKit

class SignUpViewController: FormViewController {
    
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // Set a background color
    
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Up", style: .plain, target: self, action: #selector(signUpTapped)) 
//        navigationItem.rightBarButtonItem?.title = "Sign up"

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setupForm()
      
        submitTapped()
 
    }
    
    
    
    func setupForm() {
        form +++ Section("Add New User")
        
        <<< TextRow() { row in
            row.title = "Username"
            row.placeholder = "Enter new Username"
            row.tag = "Username"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow() { row in
            row.title = "Password"
            row.placeholder = "Enter new Password"
            row.tag = "Password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        <<< TextRow() { row in
            row.title = "Email"
            row.placeholder = "Enter Your Email"
            row.tag = "Email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        <<< ButtonRow() { row in
            row.title = "Sign Up"
            row.onCellSelection { cell, row in
                
                self.setupSignUpButtonItem()
            }
        }
    }
    
    
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func submitTapped() {
        
        let usernameRow: TextRow? = form.rowBy(tag: "Username")
        let passwordRow: TextRow? = form.rowBy(tag: "Password")
        let emailRow: TextRow? = form.rowBy(tag: "Email")
        let balanceRow: DecimalRow? = form.rowBy(tag: "Balance")
        
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let email = emailRow?.value ?? ""
        let balance = balanceRow?.value ?? 0
        
        
        // Assuming User now doesn't require an 'id' for initialization
        let user = User(username: username, email: email, password: password, balance: balance)
        NetworkManager.shared.signup(user: user) { response in
            
            // Handling Network Request
            DispatchQueue.main.async {
                
                switch response {
                    
                case .success(let tokenResponse):
                    print(tokenResponse.token)
                    let profileViewController = ProfileViewController()
                    profileViewController.token = tokenResponse.token
                    self.navigationController?.pushViewController(profileViewController, animated: true)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func setupSignUpButtonItem() {
           let isFormValid = form.validate().isEmpty

           if isFormValid {
               let profileViewController = ProfileViewController()
submitTapped()
                       self.navigationController?.pushViewController(profileViewController, animated: true)
           } else {

           }
       }
}
