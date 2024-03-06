//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Saleh Bin Essa on 06/03/2024.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
    var recivedUserName: String?
    var recivedPassword: String?
    var recivedEmail: String?
    
    let generateContainer = UIView()
    let usernameLabel = UILabel()
    let passwordLabel = UILabel()
    let emailLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let appearance = UINavigationBarAppearance()
       
        title = "Profile"
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
        setUpUI()
    }
    func setUpUI(){
        view.addSubview(generateContainer)
        generateContainer.addSubview(usernameLabel)
        generateContainer.addSubview(passwordLabel)
        generateContainer.addSubview(emailLabel)
        
//        userUIImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview().offset(0)
//        }
        
        generateContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.width.equalTo(50).offset(200)
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom)
        }

          emailLabel.snp.makeConstraints { make in
              make.top.equalTo(emailLabel.snp.bottom)
        }

        
//        employeeUIImageView.image = UIImage(named: recivedemployeeImage ?? "")
        generateContainer.backgroundColor = .gray
        generateContainer.layer.cornerRadius = 10
        usernameLabel.text = "Name: \(recivedUserName ?? "" )"
        passwordLabel.text = "Phone: \(recivedPassword ?? "" )"
        emailLabel.text = "Email: \(recivedEmail ?? "" )"
        
        usernameLabel.textColor = .white
        passwordLabel.textColor = .white
        emailLabel.textColor = .white

        
        usernameLabel.font = .boldSystemFont(ofSize: 17)
        passwordLabel.font = .boldSystemFont(ofSize: 17)
        emailLabel.font = .boldSystemFont(ofSize: 17)
    }
}
