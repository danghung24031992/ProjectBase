//
//  SignInViewController.swift
//  ChatRealtime
//
//  Created Dang Hung on 10/29/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import YogaKit
import Localize_Swift

class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    var nav:NavView!
    //MARK: UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: log for test Dotzu framework
        NotificationCenter.default.addObserver(self, selector: #selector(language), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
//        NetworkManager.shared.login(username: "hungnd", password: "123456") {
//            print("")
//        }
        
        NetworkManager.shared.register("hungnd", "hungnd@gmail.com", "123456")
            .then{ user in
                DLog.verbose(user.username)
            }
            .catch { (err) in
                DLog.verbose(err.localizedDescription)
        }
        
        NetworkManager.shared.example("abc","abc")
            .then{ result in
                print(result)
        }
            .catch{error in
                print(error)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setupUI(){
        self.view.configureLayout{ (layout) in
            layout.isEnabled = true
            layout.width = YGValue(self.view.bounds.size.width)
            layout.height = YGValue(self.view.bounds.size.height)
        }
        
        let navRect = CGRect(x: 0, y: 0, width:Config.widthS, height:44 + Helper.topPadding)
        nav = NavView(frame:navRect)
        self.view.addSubview(nav)
        
        
        nav.btnBack.addTargetClosure {[weak self] (button)  in
            self?.navigationController?.popViewController(animated: true)
        }
        self.view.yoga.applyLayout(preservingOrigin: true)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.view.configureLayout{ (layout) in
            layout.width = YGValue(size.width)
            layout.height = YGValue(size.height)
        }
        self.view.yoga.applyLayout(preservingOrigin: true)
    }
    
    @objc func language(){
        nav.language()
    }
    
    @IBAction func didTouchButtonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
