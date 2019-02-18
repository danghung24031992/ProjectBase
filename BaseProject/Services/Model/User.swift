//
//  User.swift
//  ChatRealtime
//
//  Created by Dang Hung on 10/31/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import SwiftyJSON

struct User{
    let identifier:Int
    let username:String
    let email:String
    let phone_no:String
    let address:String?
}

extension User{
    enum PropertyKey: String {
        case identifier, username, email, phone_no, address
    }
    
    init(json:JSON) {
        identifier = json[PropertyKey.identifier.rawValue].intValue
        username = json[PropertyKey.username.rawValue].stringValue
        email = json[PropertyKey.email.rawValue].stringValue
        phone_no = json[PropertyKey.phone_no.rawValue].stringValue
        address = json[PropertyKey.address.rawValue].stringValue
    }
}
