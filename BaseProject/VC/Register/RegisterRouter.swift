//
//  RegisterRouter.swift
//  ChatRealtime
//
//  Created Dang Hung on 10/29/18.
//  Copyright © 2018 Dang Hung. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RegisterRouter: RegisterWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = RegisterViewController(nibName: nil, bundle: nil)
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        let presenter = RegisterPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
