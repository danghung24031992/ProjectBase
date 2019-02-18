//
//  Result.swift
//  BaseProject
//
//  Created by HUNGND on 2/17/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

//import Foundation
//
//enum Status: String {
//    case success = "1"
//    case failure = "0"
//    case unknown = ""
//}
//
//enum ErrorCode: String {
//    case success = "0"
//    case failure = "1"
//    case unknown = ""
//}
//
//enum Result<Value> {
//    case success(Status, data: Value)
//    case error(ErrorCode, description: String?)
//}
//
//extension Result {
//    func map<T>(_ transform: (Value) -> T) -> Result<T> {
//        switch self {
//        case let .success(code, data: value):
//            return .success(code, data: transform(value))
//        case let .error(code, description: description):
//            return .error(code, description: description)
//        }
//    }
//}

import SwiftyJSON

struct Result{
    let status: String
    let error_code: String
    let message: String?
    let data: Any?
}

extension Result{
    enum PropertyKey: String {
        case status, error_code, message, data
    }
    
    init(json:JSON) {
        status = json[PropertyKey.status.rawValue].stringValue
        error_code = json[PropertyKey.error_code.rawValue].stringValue
        message = json[PropertyKey.message.rawValue].stringValue
        if(json[PropertyKey.data.rawValue].type == .array){
            data = json[PropertyKey.data.rawValue].arrayValue
        }else{
            data = json[PropertyKey.data.rawValue].dictionaryValue
        }
    }
}

//{
//    "status": "1",
//    "error_code": "0",
//    "message": "Register successfully.",
//    "data": {
//    }
//}
