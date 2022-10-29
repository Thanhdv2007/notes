//
//  HomePageDIContainer.swift
//  note
//
//

import Foundation
final class HomePageDIContainer {
    struct Dependencies {
        let local: RealmManager
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeTaskUC() -> TaskGetUC {
        return DefaultTaskGetUC(repository: makeTaskRepository())
    }
    
    
    func makeTaskRepository() -> TaskRepository {
        return TasksRepositoryImpl(realmLocal: dependencies.local)
    }
    
    func makeHomeCoordinator(navigationController: BaseNavigationVC? = nil) -> HomeCoordinator{
        return HomeCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeHomeViewModel(action: HomeViewModelActions) -> HomeViewModel{
        return DefaultHomeViewModel(action: action, taskUC: makeTaskUC())
    }
    
    
}

extension HomePageDIContainer: HomeCoordinatorDependencies {
    func makeHomeViewController(action: HomeViewModelActions) -> HomeScreenVC {
        return HomeScreenVC.create(viewModel: makeHomeViewModel(action: action))
    }
    
    
}
