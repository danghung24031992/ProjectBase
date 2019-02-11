//
//  NavView.swift
//  ChatRealtime
//
//  Created by Dang Hung on 11/8/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//

import UIKit
import YogaKit
import Localize_Swift
import UIFontComplete

class NavView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var btnBack: UIButton!
    var txtTitle:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    
    // MARK:  init view using yogakit
    func commoninit(){
        //setup view size
        self.configureLayout{ (layout) in
            layout.isEnabled = true
            layout.width = YGValue(self.bounds.size.width)
            layout.height = YGValue(self.bounds.size.height)
        }
        
        self.backgroundColor = Config.mainColor
        
        //add content view
        let contentView = UIView()
        contentView.backgroundColor = Config.mainColor
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.marginLeft = 0
            layout.marginRight = 0
            layout.flexGrow = 1
            layout.marginTop = YGValue(Helper.topPadding)
            layout.alignItems = .center
        }
        self.addSubview(contentView)
        
        //add title navigation
        
        txtTitle = UILabel()
        txtTitle.textAlignment = .center
        txtTitle.textColor = .white
        txtTitle.configureLayout{ (layout)  in
            layout.isEnabled = true
            layout.flexGrow = 1
            layout.alignSelf = .center
            layout.alignContent = .center
            layout.marginLeft = 60
            layout.marginRight = 60
        }
        contentView.addSubview(txtTitle)
        
        //add button back
        btnBack = UIButton(type: .system)
        btnBack.setTitleColor(.white, for: .normal)
        btnBack.configureLayout{ (layout)  in
            layout.isEnabled = true
            layout.flexShrink = 1
            layout.alignSelf = .center
            layout.position = .absolute
            layout.marginLeft = 8
        }
        contentView.addSubview(btnBack)
        language()
        self.yoga.applyLayout(preservingOrigin: true)
    }
    
    @objc func language(){
        if let title = txtTitle {
            title.text = "Login".localized()
            title.font = CustomFont.helveticaNeueMedium.of(size: 16.0)
        }
        
        if let back = btnBack {
            back.setTitle("Back".localized(), for: .normal)
            back.titleLabel?.font = CustomFont.helveticaNeue.of(size: 16.0)
        }
    }
    
}
