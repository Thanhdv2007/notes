//
//  RealmManager.swift
//  ToDo
//
//

import Foundation
import RealmSwift

class RealmManager {
    private let realmSchemaVersion: UInt64 = 1
    
    static var shared = RealmManager()
    
    private init() {}
    
    lazy var realm: Realm = {
        let config = Realm.Configuration(schemaVersion: realmSchemaVersion)
        Realm.Configuration.defaultConfiguration = config
        
        return try! Realm()
    }()
    
    func printURL() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print("Loi =>", error.localizedDescription)
        }
    }
    
    
    
    public func saveUser(user: UserModelDTO) {
        write {
            realm.add(user)
        }
    }

    
    func saveTask(list: TaskModelDTO) {
        write {
            realm.add(list)
        }
    }
    
    func saveTaskToInfo(list: TaskModelDTO, in user: UserModelDTO) {
        write {
            user.lists.append(list)
        }
    }
    
    func saveSubtask(task: SubTaskModelDTO, in list:TaskModelDTO ) {
        write {
            list.subTask.append(task)
        }
    }
    
    func deleteAllTasks(list: TaskModelDTO) {
        write {
            list.subTask.removeAll()
        }
    }

    func deleteTask(list: TaskModelDTO) {
        write {
            realm.delete(list.subTask)
            realm.delete(list)
        }
    }
    
    func deleteSubtask(task: SubTaskModelDTO, index: Int, from list: TaskModelDTO) {
        write {
            list.subTask.remove(at: index)
            realm.delete(task)
        }
    }
    
    func updateTask(task: TaskModelDTO, updatingTask: TaskModelDTO) {
        write {
            task.title = updatingTask.title
            task.descript = updatingTask.descript
            task.dateString = updatingTask.dateString
        }
    }
    
    func updateSucces(in task: SubTaskModelDTO) {
        write {
            task.isComplete.toggle()
        }
    }
}
