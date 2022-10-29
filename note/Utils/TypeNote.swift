//
//  TypeNote.swift
//  note
//
//

import Foundation
import RealmSwift

enum TypeNote:  Int, PersistableEnum, CaseIterable {
    case note = 1
    case task = 2
}


enum TaskStatus:  Int, PersistableEnum, CaseIterable {
    case todo = 1
    case complete = 2
}
