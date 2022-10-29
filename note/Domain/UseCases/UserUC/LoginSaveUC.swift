//
//  UserSaveUC.swift
//  note
//
//

import Foundation


protocol LoginSaveUC {
    func execute(user: UserLogin, completion: @escaping (Result<Void, Error>) -> Void)
}

final class DefaultUserSaveUC: LoginSaveUC {
    
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(user: UserLogin, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.registerUser(user: user, completion: completion)
    }
    
    
}
