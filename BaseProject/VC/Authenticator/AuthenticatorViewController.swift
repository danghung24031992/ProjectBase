//
//  AuthenticatorViewController.swift
//  ChatRealtime
//
//  Created Dang Hung on 10/29/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Localize_Swift

class AuthenticatorViewController: BaseViewController, AuthenticatorViewProtocol {

	var presenter: AuthenticatorPresenterProtocol?

    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var btnVietNamLng: UIButton!
    
    @IBOutlet weak var btnEnglishLng: UIButton!
    
    //MARK: UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(language), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    
    // MARK:  localized
    
    
    @objc func language(){
        btnSignIn.setTitle("Login".localized(), for: .normal)
        btnRegister.setTitle("Sign up a new account".localized(), for: .normal)
    }
    
    
    // MARK:  action
    @IBAction func didTouchSignIn(_ sender: Any) {
        self.presenter?.pushToLogin()
        
    }
    
    @IBAction func didTouchregister(_ sender: Any) {
        
    }
    
    @IBAction func didTouchVN(_ sender: Any) {
        Localize.setCurrentLanguage("vi")
        changeColor(true , btnVietNamLng)
        changeColor(false , btnEnglishLng)
    }
    
    
    @IBAction func didTouchEng(_ sender: Any) {
        Localize.resetCurrentLanguageToDefault()
        changeColor(false , btnVietNamLng)
        changeColor(true , btnEnglishLng)
    }
    
    func changeColor(_ active : Bool , _ button : UIButton){
        if(active){
            button.setTitleColor(UIColor.gray, for: .normal)
        }else{
            button.setTitleColor(UIColor(hexString: "#0A60FF"), for: .normal)
        }
    }
    
    deinit {
        // Release all resources
        // perform the deinitialization
    }

}
