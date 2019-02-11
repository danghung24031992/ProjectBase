//
//  Helper.swift
//  BaseProject
//
//  Created by HUNGND on 2/10/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import UIKit

public struct Helper{
    static let window = UIApplication.shared.keyWindow
    static let topPadding: CGFloat = {
        if #available(iOS 11.0, *){
            return window?.safeAreaInsets.top ?? 20.0
        }
        return 20.0
    }()
    
    static let bottomPadding: CGFloat = {
        if #available(iOS 11.0, *){
            return window?.safeAreaInsets.bottom ?? 0.0
        }
        return 0.0
    }()
}
