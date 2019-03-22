//
//  PathService.swift
//  BaseProject
//
//  Created by HUNGND on 2/25/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import Foundation

struct PathService {
    
    static let Login = "/login"
    static let Register = "/register"
    static func example(_ param1:String ,_ param2 : String)->String{
        return "/example?param1=\(param1)&param2=\(param2)"
    }
}
