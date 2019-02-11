//
//  User.swift
//  ChatRealtime
//
//  Created by Dang Hung on 10/31/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import UIKit
import Mapper

struct User: Mappable {
    let identifier:Int
    let username:String
    let email:String
    let phone_no:String
    let address:String?
    
    init(map:Mapper) throws {
        try identifier = map.from("id")
        try username = map.from("user_name")
        try email = map.from("email")
        try phone_no = map.from("phone_no")
        address = map.optionalFrom("address")
    }
    
}
