//
//  File.swift
//  note
//
//

import Foundation

struct TaskViewModelActions {
    
}

protocol TaskViewModelOutput {
    var listSubTasks: [SubTaskModelDTO] { get }
    var actions: TaskViewModelActions? { get }
}

protocol TaskViewModeInput {
    func didSuccessTask()
    func didRemoveTask()
    func didFavorite()
}

protocol TaskViewModel: TaskViewModelOutput,TaskViewModeInput { }

final class DefaultTaskViewModel: TaskViewModel {
    var listSubTasks: [SubTaskModelDTO]
    var actions: TaskViewModelActions?
    
    init(listSubTasks: [SubTaskModelDTO], actions: TaskViewModelActions? = nil) {
        self.listSubTasks = listSubTasks
        self.actions = actions
    }
    
}

extension DefaultTaskViewModel {
    func didSuccessTask() {
        
    }
    
    func didRemoveTask() {
        
    }
    
    func didFavorite() {
        
    }
    
}
