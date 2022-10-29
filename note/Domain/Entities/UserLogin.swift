//
//  User.swift
//  note
//
//

import RealmSwift


struct UserLogin: Codable {
    var id: String?
    var email: String
    var password: String
    var date: Date = Date()
}
