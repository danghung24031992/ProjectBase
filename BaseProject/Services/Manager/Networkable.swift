//
//  Networkable.swift
//  ChatRealtime
//
//  Created by Dang Hung on 11/8/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import Moya
import  Promises

protocol Networkable {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
    func login(username:String , password:String , completion:@escaping()->())
    func register(_ username:String , _ email:String , _ hashedPassword:String)->Promise<User>
}
