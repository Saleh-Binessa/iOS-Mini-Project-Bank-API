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
    
    var users: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // Set a background color
    
        let appearance = UINavigationBarAppearance()
        title = "Sign Up"
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sign up"), style: .plain, target: self, action: #selector(signUpTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setupForm()
        fetchPetsData()
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
        
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let email = emailRow?.value ?? ""
        
        
        // Assuming User now doesn't require an 'id' for initialization
        let user = User(username: username, email: email, password: password)
        NetworkManager.shared.signup(user: user) { response in
            
            // Handling Network Request
            DispatchQueue.main.async {
                
                switch response {
                    
                case .success(let tokenResponse):
                    print(tokenResponse.token)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchPetsData() {
       NetworkManager.shared.fetchUsers { fetchedUsers in
           DispatchQueue.main.async {
               self.users = fetchedUsers ?? []
               self.tableView.reloadData()
           }
       }
   }
    
    @objc private func signUpTapped() {
        let navigationController = UINavigationController(rootViewController: ProfileViewController())
        present(navigationController, animated: true, completion: nil)
    }

}
