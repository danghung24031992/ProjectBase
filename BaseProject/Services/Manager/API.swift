//
//  API.swift
//  ChatRealtime
//
//  Created by Dang Hung on 10/31/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import Foundation
import Moya

enum API{
    case register(_ username:String ,_ email:String ,_ hashedPassword:String)
    case login(username:String , password:String)
    case example(_ param1:String ,_ param2:String)
}

extension API:TargetType{
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: ["api_key": ""], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .example:
            return ["Accept": "application/json",
                    "Content-type": "application/json"]
        default:
            return ["Accept": "application/json",
                    "Content-type": "application/json"]
        }
    }
    
    
    var environmentBaseURL:String{
        switch NetworkManager.environment {
        case .product:
            return ""
        case .qa:
            return ""
        case .staging:
            return ""
        case .developer:
            return "https://www.google.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else{fatalError("base URL could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .login(let username , let password):
            return "/login?username=\(username)&password=\(password)"
        case .example(let param1, let param2):
            return PathService.example(param1, param2)
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .example:
            return .post
        default:
            return .get
        }
    }
    
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var validationType: ValidationType {
        return .none
    }
}
