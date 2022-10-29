//
//  UserRepository.swift
//  note
//
//

import Foundation

protocol LoginRepository {
    func getUser(email: String, completion: @escaping (Result<UserModelDTO?, Error>) -> Void)
    func registerUser(user: UserLogin, completion: @escaping (Result<Void, Error>) -> Void)
}
