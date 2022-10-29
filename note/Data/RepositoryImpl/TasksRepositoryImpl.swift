//
//  TasksRepositoryImpl.swift
//  note
//
//

import Foundation
import RealmSwift

final class TasksRepositoryImpl {
    private let local: RealmManager
    
    init(realmLocal: RealmManager) {
        self.local = realmLocal
    }
}

extension TasksRepositoryImpl: TaskRepository {
    func executeGetTask(in currentUser: UserLogin, completion: @escaping (List<TaskModelDTO>?) -> Void) {
        guard let user = RealmManager.shared.realm.objects(UserModelDTO.self).where({ $0.email ==  currentUser.email}).first else  {
            completion(nil)
            return
        }
        print("ahi")
        completion(user.lists)
        
    }
    
    func executeSaveTask(newTask: TaskModelDTO,in currentUser: UserModelDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        RealmManager.shared.saveTaskToInfo(list: newTask, in: currentUser)
    }
    
    func executeSaveSubTask(new newTask: TaskModelDTO, in oldTask: TaskModelDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    
}
