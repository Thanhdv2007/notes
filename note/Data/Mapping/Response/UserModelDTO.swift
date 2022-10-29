//
//  UserModel.swift
//  note
//

import RealmSwift


class UserModelDTO: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    @Persisted var timeRegister: Date = Date()
    @Persisted var lists = List<TaskModelDTO>()
    
   
}

extension UserModelDTO: DomainConvertible {
    typealias T = UserLogin
    
    func toDomain() -> UserLogin {
        return .init(id: _id.stringValue, email: email, password: password,date: timeRegister)
    }
    
}
