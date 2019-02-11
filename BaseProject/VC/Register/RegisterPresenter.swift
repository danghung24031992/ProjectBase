//
//  RegisterPresenter.swift
//  ChatRealtime
//
//  Created Dang Hung on 10/29/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RegisterPresenter: RegisterPresenterProtocol, RegisterInteractorOutputProtocol {

    weak private var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    private let router: RegisterWireframeProtocol

    init(interface: RegisterViewProtocol, interactor: RegisterInteractorInputProtocol?, router: RegisterWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}