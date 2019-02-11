//
//  AccountPresenter.swift
//  BaseProject
//
//  Created HUNGND on 2/10/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class AccountPresenter: AccountPresenterProtocol, AccountInteractorOutputProtocol {

    weak private var view: AccountViewProtocol?
    var interactor: AccountInteractorInputProtocol?
    private let router: AccountWireframeProtocol

    init(interface: AccountViewProtocol, interactor: AccountInteractorInputProtocol?, router: AccountWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
