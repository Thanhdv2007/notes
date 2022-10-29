//
//  LoginSceneDIContainer.swift
//  note
//
//

import Foundation

final class LoginSceneDIContainer {
    
    struct Dependencies {
         let local: RealmManager
    }
    
    private let dependencies: Dependencies

    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeGetLoginUseCase() -> LoginGetUC {
        return DefaultUserGetUserUC(repository: makeReviewRepository())
    }
    
    // MARK: - Use Cases
    func makeSaveLoginUseCase() -> LoginSaveUC {
        return DefaultUserSaveUC(repository: makeReviewRepository())
    }
    
    // MARK: - Repositories
    func makeReviewRepository() -> LoginRepository {
        return UserLoginRepositoryImpl(realmLocal: dependencies.local)
    }
    
    // MARK: - make login
    func makeLoginViewController(action: LoginViewModelActions) -> LoginVC {
        return LoginVC.create(with: makeLoginViewModel(action: action))
    }
    
    func makeLoginViewModel(action: LoginViewModelActions) -> LoginViewModel {
        return DefaultLoginViewModel(getUser: makeGetLoginUseCase(),action: action)
    }
    
    func makeLoginCoordinator(navigationController: BaseNavigationVC? = nil) -> LoginCoordinator {
        return LoginCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - make register
    func makeRegisterViewModel(userLogin: String,action: RegisterViewModelActions) -> RegisterViewModel {
        return DefaultRegisterViewModel(userLogin: userLogin,getUC: makeGetLoginUseCase(), saveUC: makeSaveLoginUseCase(),action: action)
    }
    
    func makeRegisterCoordinator(navigationController: BaseNavigationVC? = nil) -> RegisterCoordinator {
        return RegisterCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeRegisterViewController(user: String,action: RegisterViewModelActions) -> RegisterVC {
        return RegisterVC.create(with: makeRegisterViewModel(userLogin: user, action: action))
    }
    
    
}



extension LoginSceneDIContainer:  LoginCoordinatorDependencies, RegisterCoordinatorDependencies {}
