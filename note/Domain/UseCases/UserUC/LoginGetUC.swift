//
//  UserUC.swift
//  note
//
//

import Foundation


protocol LoginGetUC {
    func execute(email: String,completion: @escaping (Result<UserModelDTO?, Error>) -> Void)
}

final class DefaultUserGetUserUC: LoginGetUC {
 
    
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(email: String,completion: @escaping (Result<UserModelDTO?, Error>) -> Void) {
        repository.getUser(email: email, completion: completion)
    }
}
