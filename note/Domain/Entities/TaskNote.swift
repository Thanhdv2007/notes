//
//  TaskNote.swift
//  note
//
//

import Foundation

struct TaskModel  {
    var _id: String
    var title: String = ""
    var descript : String = ""
    var dateString = Date()
    var typeNode: TypeNote = .note
    var subTask: [SubTaskModel]
    
}


struct SubTaskModel {
    var _id: String
    var title: String
    var dateString: Date
    var isComplete: Bool = false
}
