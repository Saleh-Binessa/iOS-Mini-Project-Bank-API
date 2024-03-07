//
//  SignInViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Saleh Bin Essa on 06/03/2024.
//

import Foundation
import Eureka
import UIKit
import Alamofire
import Kingfisher

class SignInViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        
    }
    
    func setupForm() {
        form +++ Section("Sign In")
        
        <<< TextRow() { row in
            row.title = "Username"
            row.placeholder = "Enter your Username"
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
            row.placeholder = "Enter Password"
            row.tag = "Password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow(){ row in
            row.title = "SignIn"
            row.onCellSelection{ cell , row in
                
                self.submitTapped()
            }
            
        }
    }
   
    @objc func submitTapped(){
        let isFormValid = form.validate().isEmpty

        let usernameRow: TextRow? = form.rowBy(tag: "Username")
        let passwordRow: TextRow? = form.rowBy(tag: "Password")
        
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let user = User(username: username, email: nil, password: password, balance: nil)

        if isFormValid {
            NetworkManager.shared.signin(user: user) { response in
                
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

        } else {
            print("CHECK YOUR CREDENTIALS")
        }
        
       
    }

}
