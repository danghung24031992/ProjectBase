//
//  NetworkManager.swift
//  ChatRealtime
//
//  Created by Dang Hung on 10/31/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    case qa
    case product
}

struct NetworkManager:Networkable {
    static let shared = NetworkManager()
    
    internal let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose:true)])
    
    let environment:APIEnvironment = .staging
    
    func login(username: String, password: String, completion: @escaping () -> ()) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                print(response.description)
                break
            case let .failure(error):
                print(error)
                break
            }
            completion()
        }
    }
    
    func register(username: String, email: String, hashedPassword: String) {
        
    }
}

