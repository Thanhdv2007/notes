//
//  TabbarPageDIContainer.swift
//  note
//
//

import Foundation
final class TabbarPageDIContainer {
    struct Dependencies {
        let local: RealmManager
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeTabbarCoordinator(navigationController: BaseNavigationVC? = nil) -> TabbarCoordinator{
        return TabbarCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeTabbarViewModel(action: TabbarViewModelActions) -> TabbarViewModel{
        return DefaultTabbarViewModel(actions: action)
    }
    
}

extension TabbarPageDIContainer: TabbarCoordinatorDependencies {
    func makeTabbarViewController(action: TabbarViewModelActions) -> MainTabController {
        return MainTabController.create(with: makeTabbarViewModel(action: action))
    }
    
    
    
}
