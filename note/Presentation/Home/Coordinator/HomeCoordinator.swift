//
//  HomeCoordinator.swift
//  note
//
//

import Foundation

protocol HomeCoordinatorDependencies  {
    func makeHomeViewController(action: HomeViewModelActions) -> HomeScreenVC
}

class HomeCoordinator {
    
    private var navigationController: BaseNavigationVC?
    private let dependencies: HomeCoordinatorDependencies
    
    private weak var homeVC: HomeScreenVC?
    private weak var mainTabController: MainTabController?
    var actionMenu: () -> Void = {}
    
    init(navigationController: BaseNavigationVC?,
         dependencies: HomeCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        actionMenu = {
            let modalVC = ModelCreateView()
            modalVC.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(modalVC, animated: true, completion:  nil)
        }
        
    }
    
    func start() {
        let action = HomeViewModelActions(gotoCreateTask: gotoCreateTask, gotoCreateNote: gotoCreateNote, gotoMenu: gotoMenu, gotoLogin: gotoLogin)
        let vc = dependencies.makeHomeViewController(action: action)
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.present(vc, animated: true)
        homeVC = vc
    }
    
    func visible(_ mainTabController: MainTabController?) -> BaseNavigationVC {
        let action = HomeViewModelActions(gotoCreateTask: gotoCreateTask, gotoCreateNote: gotoCreateNote, gotoMenu: gotoMenu, gotoLogin: gotoLogin)
         let vc = dependencies.makeHomeViewController(action: action)
        self.mainTabController = mainTabController
        homeVC = vc
        self.navigationController = BaseNavigationVC(rootViewController: vc)
        return navigationController ?? BaseNavigationVC()
    }
    
    func gotoCreateTask(title: String) {
        
    }
    func gotoCreateNote() { }
    func gotoMenu() { }
    func gotoLogin() { }
    
}
