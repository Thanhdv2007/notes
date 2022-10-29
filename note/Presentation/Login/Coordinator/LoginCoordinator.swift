//
//  LoginCoordinator.swift
//  note
//
//

import Foundation


protocol LoginCoordinatorDependencies  {
    func makeLoginViewController(action: LoginViewModelActions) -> LoginVC
}

class LoginCoordinator {
    
    private weak var navigationController: BaseNavigationVC?
    private let dependencies: LoginCoordinatorDependencies
    
    private weak var loginVC: LoginVC?
    private weak var registerVC: RegisterVC?
    
    init(navigationController: BaseNavigationVC?,
         dependencies: LoginCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = LoginViewModelActions(gotoHome: gotoHome, gotoRegister: gotoRegister)
        let vc = dependencies.makeLoginViewController(action: action)
        navigationController?.pushViewController(vc, animated: true)
        loginVC = vc
    }
    
    func visible() -> BaseNavigationVC{
        let vc = dependencies.makeLoginViewController(action: .init(gotoHome: gotoHome, gotoRegister: gotoRegister))
        loginVC = vc
        let navi = BaseNavigationVC(rootViewController: vc)
        navigationController = navi
        navi.modalPresentationStyle = .overFullScreen
        return navi
    }
    
    func gotoHome() {
        
    }
    
    func gotoRegister(user: String){
        print("gotoRegister")
        let container = appDIContainer.makeLoginSceneDIContainer()
        let vc = container.makeRegisterCoordinator(navigationController: navigationController)
        vc.start(user: user)
    }
    
}
