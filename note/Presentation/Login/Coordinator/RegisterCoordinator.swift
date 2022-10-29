//
//  RegisterCoordinator.swift
//  note
//
//

import Foundation
import UIKit


protocol RegisterCoordinatorDependencies  {
    func makeRegisterViewController(user: String, action: RegisterViewModelActions) -> RegisterVC
}

class RegisterCoordinator {
    
    private weak var navigationController: BaseNavigationVC?
    private let dependencies: RegisterCoordinatorDependencies
    
    private weak var registerVC: RegisterVC?
    
    init(navigationController: BaseNavigationVC?,
         dependencies: RegisterCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(user: String) {
        let action = RegisterViewModelActions(gotoLogin: gotoLogin, gotoHome: gotoHome)
        let vc = dependencies.makeRegisterViewController(user: user, action: action)
        registerVC = vc
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func gotoLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gotoHome() {
        let dependencies = appDIContainer.makeTabbarMainDIContainer()
        let vc = dependencies.makeTabbarCoordinator().visible()
        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationController?.navigationBar.shadowImage = nil
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.present(vc, animated: false)
    }
    
    
}
