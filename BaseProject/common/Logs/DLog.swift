//
//  DLog.swift
//  BaseProject
//
//  Created by HUNGND on 2/17/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import Dotzu

public struct DLog{
    static func verbose(_ msg:String?){
        Logger.verbose(msg ?? "")
    }
    
    static func info(_ msg:String?){
        Logger.info(msg ?? "")
    }
    
    static func warning(_ msg:String?){
        Logger.warning(msg ?? "")
    }
    
    static func error(_ msg:String?){
        Logger.error(msg ?? "")
    }
    
    static func logNetwork(_ configuration:URLSessionConfiguration){
        Dotzu.sharedManager.addLogger(session: configuration)
    }
}
