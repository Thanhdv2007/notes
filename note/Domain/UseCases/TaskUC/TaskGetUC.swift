//
//  TaskGetUC.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import RealmSwift

protocol TaskGetUC {
    func executeGetTask(in currentUser: UserLogin, completion: @escaping (List<TaskModelDTO>?) -> Void)
    func executeSaveTask(in task: TaskModelDTO,completion: @escaping (Result<[SubTaskModelDTO]?, Error>) -> Void)
    func executeSaveSubTask(task: SubTaskModelDTO, in list: TaskModelDTO, completion: @escaping (Result<[SubTaskModelDTO]?, Error>) -> Void)
}

final class DefaultTaskGetUC: TaskGetUC {
  
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
}

extension DefaultTaskGetUC {
    func executeGetTask(in currentUser: UserLogin, completion: @escaping (List<TaskModelDTO>?) -> Void) {
//        repository.executeGetTask(in: currentUser,completion: completion)
        repository.executeGetTask(in: currentUser, completion: completion)
    }
    
    func executeSaveTask(in task: TaskModelDTO, completion: @escaping (Result<[SubTaskModelDTO]?, Error>) -> Void) {
        
    }
    
    func executeSaveSubTask(task: SubTaskModelDTO, in list:TaskModelDTO , completion: @escaping (Result<[SubTaskModelDTO]?, Error>) -> Void) {
        
    }
    
}
