//
//  NetworkManager.swift
//  ChatRealtime
//
//  Created by Dang Hung on 10/31/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import  Promises
import SwiftyJSON

enum APIEnvironment {
    case developer
    case staging
    case qa
    case product
}

func defaultAlamofireManager() -> Manager {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 60000
    DLog.logNetwork(configuration)
    let manager = Alamofire.SessionManager(configuration: configuration)
    manager.startRequestsImmediately = true
    return manager
}

struct NetworkManager:Networkable {
    static let shared = NetworkManager()
    
    internal let provider = MoyaProvider<API>(manager:defaultAlamofireManager(),plugins: [NetworkLoggerPlugin(verbose:true)])
    
    static let environment:APIEnvironment = {
        #if STAGING
        return APIEnvironment.staging
        #elseif QA
        return APIEnvironment.qa
        #elseif PRODUCTION
        return APIEnvironment.product
        #endif
        return APIEnvironment.developer
    }()
    
    func logError(_ error:MoyaError)-> Void{
        switch error {
        case .imageMapping(let response):/// Indicates a response failed to map to an image.
            DLog.error(response.debugDescription)
        case .jsonMapping(let response):/// Indicates a response failed to map to a JSON structure.
            DLog.error(response.debugDescription)
        case .statusCode(let response): /// Indicates a response failed with an invalid HTTP status code.
            DLog.error(response.debugDescription)
        case .stringMapping(let response):/// Indicates a response failed to map to a String.
            DLog.error(response.debugDescription)
        case .objectMapping(let error, let response):/// Indicates a response failed to map to a Decodable object.
            // error is DecodingError
            DLog.error(error.localizedDescription + response.debugDescription)
        case .encodableMapping(let error):/// Indicates that Encodable couldn't be encoded into Data
            DLog.error(error.localizedDescription)
        case .underlying(let nsError as NSError, let response):/// Indicates a response failed due to an underlying `Error`.
            // now can access NSError error.code or whatever
            // e.g. NSURLErrorTimedOut or NSURLErrorNotConnectedToInternet
            guard let statusCode = response?.statusCode else { DLog.error("status code not found"); return }
            DLog.error("\(nsError.code) \n \(nsError.domain) \n \(statusCode)")
        case .requestMapping(let url):/// Indicates that an `Endpoint` failed to map to a `URLRequest`.
            DLog.error(url)
        case .parameterEncoding(let error):/// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
            DLog.error(error.localizedDescription)
        }
    }
    
    private func parseJSONData(jsonData:JSON) -> Promise<Any>{
        return Promise { fulfill, reject in
            let result = Result(json: jsonData)
            if result.error_code == "0" && result.status == "1" {
                fulfill(result.data ?? [String:Any]())
            }else{
                reject(APIError(result.error_code, result.message) as Error)
            }
        }
    }
    
    func login(username: String, password: String, completion: @escaping () -> ()) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                print(response.statusCode)
                print(response.description)
                break
            case let .failure(error):
                self.logError(error)
            }
            completion()
        }
    }
    
    func register(_ username: String, _ email: String, _ hashedPassword: String) -> Promise<User> {
        return Promise { fulfill, reject in
            self.provider.request(.register(username,email ,hashedPassword )) { result in
                switch result {
                case let .success(response):
                    do{
                        let responseFilter = try response.filter(statusCodes: 200...299)
                        let data = responseFilter.data
                        let jsonData = try JSON(data: data) // convert network data to json
                        self.parseJSONData(jsonData: jsonData).then({(jsonObj) in
                            let user = User(json: jsonObj as! JSON)
                            fulfill(user)
                        }).catch({ (error) in
                            reject(error)
                        })
                    }catch let error{
                        print(error)
                    }
                    break
                case let .failure(error):
                    self.logError(error)
                    reject(error)
                }
            }
        }
    }
    func example(_ param1:String , _ param2:String)-> Promise<Any>{
        return Promise{fulfill , reject in
            self.provider.request(.example(param1, param2), completion: {result in
                switch result {
                case let .success(response):
                    do{
                        let responseFilter = try response.filter(statusCodes: 200...299)
                        let data = responseFilter.data
                        let jsonData = try JSON(data: data) // convert network data to json
                        self.parseJSONData(jsonData: jsonData).then({(jsonObj) in
                            fulfill(jsonObj)
                        }).catch({ (error) in
                            reject(error)
                        })
                    }catch let error{
                        print(error)
                    }
                    break
                case let .failure(error):
                    self.logError(error)
                    reject(error)
                }
            })
        }
    }
}


/*
 Success:
 {
 "status": "1",
 "error_code": "0",
 "message": "Register successfully.",
 "data": {
 "user": {
 "email": "test7@test.com",
 "updated_at": "2017-04-11 03:39:57",
 "created_at": "2017-04-11 03:39:57"
 }
 }
 }
 
 Error:
 {
 "status": "0",
 "error_code": "1",
 "message": "Validate fail.",
 "data": {}
 }
 */

