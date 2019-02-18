//
//  Error.swift
//  BaseProject
//
//  Created by HUNGND on 2/17/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import Foundation
public struct APIError: Swift.Error {
    let error_code:String
    let message:String?
}

extension APIError{
    init(_ error_code:String,_ message:String?) {
        self.error_code = error_code
        self.message = message
    }
}
