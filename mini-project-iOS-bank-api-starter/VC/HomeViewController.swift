//
//  SignUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Saleh Bin Essa on 06/03/2024.
//

import Foundation

import UIKit
import SnapKit
import Kingfisher
import Eureka
import Alamofire

class HomeViewController: UIViewController {
        // Property to hold the bank account details passed from the previous view
        var user: User?

        // UI Components
    @objc private let signUpButton = UIButton()
        private let signInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set a background color
        
        
        let appearance = UINavigationBarAppearance()
        title = "Home"
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        setupViews()
        setupLayout()
        setupUI()
        

        // Add target action for the button
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        
        // Add target action for the button
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        
        view.backgroundColor = .white
    }

        private func setupViews() {
            view.addSubview(signUpButton)
            view.addSubview(signInButton)
        }

        private func setupLayout() {
            signUpButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20) // Adjust bottom spacing as needed
                make.leading.equalToSuperview().offset(0) // Adjust leading spacing as needed
                make.width.height.equalTo(100) // Example size, adjust as needed
            }

            signInButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20) // Adjust bottom spacing as needed
                make.trailing.equalToSuperview().offset(-20) // Adjust trailing spacing as needed
                make.width.height.equalTo(100) // Example size, adjust as needed
            }

            }
   private func setupUI() {
       signUpButton.setTitle("Sign Up", for: .normal)
       signUpButton.backgroundColor = .systemBlue
       signUpButton.layer.cornerRadius = 40
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.layer.cornerRadius = 40
            
            
//            profileImageView.snp.makeConstraints { make in
//                make.top.equalTo(profileImageView.snp.bottom).offset(20)
//                make.centerX.equalToSuperview()
//            }
            }
    
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func signInButtonTapped() {
        let signInVC = SignInViewController()
        signInVC.modalPresentationStyle = .fullScreen 
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    }

