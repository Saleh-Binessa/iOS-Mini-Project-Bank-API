//
//  NetworkManager.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
     let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    
    static let shared = NetworkManager()
    
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        
        AF.request(baseUrl).responseDecodable(of: [User].self) {response in
            switch response.result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    
    func account(token: String, completion: @escaping (Result<User, Error>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
       let url = baseUrl + "account"
        AF.request(baseUrl, headers: headers).responseDecodable(of: User.self) {response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
    
     func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func signin(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
           let url = baseUrl + "signin"
           AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
               switch response.result {
               case .success(let value):
                   completion(.success(value))
               case .failure(let afError):
                   completion(.failure(afError as Error))
               }
           }
       }

    private func deposite(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "withdraw"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    
    //MARK: OTHER Networking Functions
    
    
}
