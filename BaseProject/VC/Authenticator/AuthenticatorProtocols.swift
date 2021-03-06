//
//  AuthenticatorProtocols.swift
//  ChatRealtime
//
//  Created Dang Hung on 10/29/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol AuthenticatorWireframeProtocol: class {
    func pushToSignIn()
}
//MARK: Presenter -
protocol AuthenticatorPresenterProtocol: class {

    var interactor: AuthenticatorInteractorInputProtocol? { get set }
    
    func pushToLogin()
}

//MARK: Interactor -
protocol AuthenticatorInteractorOutputProtocol: class {

    /* Interactor -> Presenter */

}

protocol AuthenticatorInteractorInputProtocol: class {

    var presenter: AuthenticatorInteractorOutputProtocol?  { get set }
    /* Presenter -> Interactor */
}

//MARK: View -
protocol AuthenticatorViewProtocol: class {

    var presenter: AuthenticatorPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
