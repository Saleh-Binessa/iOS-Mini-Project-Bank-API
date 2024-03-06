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

class HomeViewController: UIViewController {
        // Property to hold the bank account details passed from the previous view
        var user: User?

        // UI Components
        private let logInButton = UIButton()
        private let signUpButton = UIButton()
        
        let petImageView = UIImageView()
        let url = URL(string: "https://example.com/image.png")
        

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupLayout()
            configureWithPet()
        }

        private func setupViews() {
            view.backgroundColor = .white

            signUpButton..addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)
            
            petAgeLabel.font = .systemFont(ofSize: 16, weight: .medium)
            petGenderLabel.font = .systemFont(ofSize: 16, weight: .medium)
            adoptionStatusLabel.font = .systemFont(ofSize: 16, weight: .medium)
            petImageView.kf.setImage(with: URL(string: pet?.image ?? "image"))


            // Add the views to the hierarchy
            view.addSubview(signUpButton)
            view.addSubview(logInButton)
            view.addSubview(petImageView)
        }

        private func setupLayout() {
            petImageView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(100)  // Example size, adjust as needed
            }

            petNameLabel.snp.makeConstraints { make in
                make.top.equalTo(petImageView.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }

            petAgeLabel.snp.makeConstraints { make in
                make.top.equalTo(petNameLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }
            petGenderLabel.snp.makeConstraints { make in
                make.top.equalTo(petAgeLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }
            adoptionStatusLabel.snp.makeConstraints { make in
                make.top.equalTo(petGenderLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }
        }

        private func configureWithPet() {
            petNameLabel.text = "Pet Name: \(pet?.name ?? "name")"
            petAgeLabel.text = "Age: \(pet?.age ?? 0)"
            petGenderLabel.text = "Gender: \(pet?.gender ?? "gender")"
            petAgeLabel.text = "Adoption Status: \(pet?.adopted ?? true)"
          petImageView.image = UIImage(named: pet?.image ?? "image")
        }
    
    @objc func signUpButtonTapped() {
        let secondVC = SignUpViewController()
        secondVC.recivedemployeeImage = imageTextField.text
        secondVC.recivedfullName = fullNameTextField.text
        secondVC.recivedEmail = emailTextField.text
        secondVC.recivedIban = ibanTextField.text
        secondVC.recivedPhoneNumber = phoneNumberTextField.text
        secondVC.recivedEmployeeSalary = employeeSalaryTextField.text
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    }

