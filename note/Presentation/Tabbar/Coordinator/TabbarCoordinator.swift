//
//  TabbarCoordinator.swift
//  note
//
//

import Foundation


protocol TabbarCoordinatorDependencies  {
    func makeTabbarViewController(action: TabbarViewModelActions) -> MainTabController
}

final class TabbarCoordinator {
    
    private weak var navigationController: BaseNavigationVC?
    private let dependencies: TabbarCoordinatorDependencies
    
    private weak var tabbarVC: MainTabController?
    
    init(navigationController: BaseNavigationVC?,
         dependencies: TabbarCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    
    func start() {
        let action = TabbarViewModelActions(gotoSideMenu: gotoSideMenu, gotoSearchView: gotoSearchView, gotoBottomSheetView: gotoBottomSheetView,gotoLogin: gotoLogin)
        let vc = dependencies.makeTabbarViewController(action: action)
        vc.modalPresentationStyle  = .overFullScreen
        navigationController?.present(vc, animated: true)
        tabbarVC = vc
    }
    
    func visible() -> BaseNavigationVC{
        let action = TabbarViewModelActions(gotoSideMenu: gotoSideMenu, gotoSearchView: gotoSearchView, gotoBottomSheetView: gotoBottomSheetView, gotoLogin: gotoLogin)
        let vc = dependencies.makeTabbarViewController(action: action)
        tabbarVC = vc
        let navi = BaseNavigationVC(rootViewController: vc)
        navigationController = navi
        navi.setNavigationBarHidden(true, animated: false)
        navi.modalPresentationStyle = .overFullScreen
        return navi
    }
    
    
}

extension TabbarCoordinator {
    func gotoSideMenu() { }
    func gotoSearchView() { }
    func gotoBottomSheetView() { }
    func gotoLogin() {
        let loginDI = appDIContainer.makeLoginSceneDIContainer()
        let loginVC = loginDI.makeLoginCoordinator().visible()
        navigationController?.present(loginVC, animated: false)
        navigationController!.viewControllers.removeAll()
    }
}
