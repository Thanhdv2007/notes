//
//  AppDIContainer.swift
//  note
//
//

import Foundation

final class AppDIContainer {
    
    lazy var realmLocal = RealmManager.shared
    
    func makeLoginSceneDIContainer() ->  LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer.Dependencies(local: realmLocal)
        return LoginSceneDIContainer(dependencies: dependencies)
    }
    
    func makeHomeSceneDIContainer() -> HomePageDIContainer {
        let dependencies = HomePageDIContainer.Dependencies(local: realmLocal)
        return HomePageDIContainer(dependencies: dependencies)
    }

    
    func makeTabbarMainDIContainer() -> TabbarPageDIContainer {
        let dependencies = TabbarPageDIContainer.Dependencies(local: realmLocal)
        return TabbarPageDIContainer(dependencies: dependencies)
    }
}
