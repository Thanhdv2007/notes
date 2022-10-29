//
//  TaskRepository.swift
//  note
//

import Foundation
import RealmSwift

protocol TaskRepository {
    func executeGetTask(in currentUser: UserLogin,completion: @escaping (List<TaskModelDTO>?) -> Void)
    func executeSaveTask(newTask: TaskModelDTO,in currentUser: UserModelDTO,completion: @escaping (Result<Void, Error>) -> Void)
    func executeSaveSubTask(new newTask: TaskModelDTO, in oldTask: TaskModelDTO,
                            completion: @escaping (Result<Void, Error>) -> Void)
}
