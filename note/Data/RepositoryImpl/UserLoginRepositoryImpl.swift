//
//  UserModelRepositoryImpl.swift
//  note
//
//

import Foundation

final class UserLoginRepositoryImpl {
    private let local: RealmManager
    
    init(realmLocal: RealmManager) {
        self.local = realmLocal
    }
}
extension UserLoginRepositoryImpl : LoginRepository{
    func getUser(email: String, completion: @escaping (Result<UserModelDTO?, Error>) -> Void) {
        print("UserLoginRepositoryImpl")
        let user = local.realm.objects(UserModelDTO.self).filter { user in
            user.email == email
        }.first
        
        completion(.success(user))
        
    }
    
    
    func registerUser(user: UserLogin, completion: @escaping (Result<Void, Error>) -> Void) {
        let _user = UserModelDTO()
        _user.email = user.email
        _user.password = user.password
        local.saveUser(user: _user)
        completion(.success(()))
    }
    
    
}
