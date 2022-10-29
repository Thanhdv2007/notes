//
//  ListModelDTO.swift
//  note
//
//

import RealmSwift

class TaskModelDTO: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var descript : String = ""
    @Persisted var dateString = Date()
    @Persisted var typeNode: TypeNote = .note
    @Persisted var subTask = List<SubTaskModelDTO>()
    
}


class SubTaskModelDTO: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var dateString = Date()
    @Persisted var isComplete: Bool = false
}


extension TaskModelDTO: DomainConvertible {
    typealias T = TaskModel
    func toDictory() -> [SubTaskModel] {
        var _subtasl: [SubTaskModel] = []
        subTask.forEach { subtask in
            _subtasl.append(subtask.toDomain())
        }
        return _subtasl
    }
    
    func toDomain() -> TaskModel {
        return .init(_id: _id.stringValue, title: title ,subTask: toDictory())
    }
    
}

extension SubTaskModelDTO: DomainConvertible {
    typealias T = SubTaskModel
    func toDomain() -> SubTaskModel {
        return .init(_id: _id.stringValue,title: title, dateString: dateString,isComplete: isComplete)
    }
    
}
