import UIKit
import SnapKit
import Kingfisher

class ProfileViewController: UIViewController {
    var token: String?
    var user: User?

    // UI Components
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let balanceLabel = UILabel()
    private let toTransactions = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set a background color

        setupViews()
        setupLayout()
        setupUI()
        fetchProfile()
    }

    private func setupViews() {
        usernameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        balanceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        // Add the views to the hierarchy
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(balanceLabel)
        view.addSubview(toTransactions)

        // Configure toTransactions button
        toTransactions.addTarget(self, action: #selector(toTransactionsButtonTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        toTransactions.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20) // Adjust bottom spacing as needed
            make.centerX.equalToSuperview() // Center the button horizontally
            make.width.equalTo(200) // Example width, adjust as needed
            make.height.equalTo(50) // Example height, adjust as needed
        }
    }

    private func setupUI() {
        if let user = user.self {
            usernameLabel.text = "Username: \(user.username ?? "username")"
            balanceLabel.text = "Balance: \(String(describing: user.balance ?? 0))"
            emailLabel.text = "Email: \(user.email ?? "email")"

        }

        toTransactions.setTitle("Transactions", for: .normal)
        toTransactions.backgroundColor = .systemBlue
        toTransactions.layer.cornerRadius = 25 // Adjusted for a more standard button height
    }

    @objc func toTransactionsButtonTapped() {
        let transactionsVC = TransactionsViewController()
        self.navigationController?.pushViewController(transactionsVC, animated: true)
    }
    
    func fetchProfile() {
        
        
        NetworkManager.shared.account(token: "account") { response in
            
            
            // Handling Network Request
            DispatchQueue.main.async {
                
                switch response {
                    
                case .success(let user):
                    print(user.username)
                    print(user.email)
                    print(user.balance)
                    

//                    let profileViewController = ProfileViewController()
//                    profileViewController.token = tokenResponse.token
//                    self.navigationController?.pushViewController(profileViewController, animated: true)
                    
                    self.usernameLabel.text = user.username
                    self.emailLabel.text = user.email
                    self.balanceLabel.text = String(user.balance ?? 0.0)

                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
