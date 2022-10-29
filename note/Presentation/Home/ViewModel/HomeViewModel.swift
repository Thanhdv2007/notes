//
//  HomeViewModel.swift
//  note
//
//  Created by Thanh on 27/10/2022.
//

import RealmSwift

struct HomeViewModelActions {
    var gotoCreateTask: (String)-> Void
    var gotoCreateNote: ()-> Void
    var gotoMenu: ()-> Void
    var gotoLogin: () -> Void
}

protocol HomeViewModelOutput {
    var tasks: Observable<[TaskModel]> { get set }
    var currentUser: UserLogin? { get }
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func createTask(title:String)
    func createSubtask(description: String)
}

protocol HomeViewModel: HomeViewModelOutput,  HomeViewModelInput{ }

final class DefaultHomeViewModel: HomeViewModel {
    var currentUser: UserLogin?
    
    var tasks: Observable<[TaskModel]>  = Observable([])
    
    var action: HomeViewModelActions?
    
    private let taskUC:TaskGetUC
        
    init(action: HomeViewModelActions?, taskUC: TaskGetUC) {
        self.action = action
        self.taskUC = taskUC
    }
    
    func loadData(){
        self.currentUser = Global.shared.loginData
        guard currentUser != nil else {
            action?.gotoLogin()
            return
        }
        taskUC.executeGetTask(in: currentUser!) {[weak self] _tasks in
            var _tempTask: [TaskModel] = []
            _tasks?.forEach({ taskDTO in
                _tempTask.append(taskDTO.toDomain())
            })
            self?.tasks.value = _tempTask
        }
    }
}


extension DefaultHomeViewModel {
    func viewDidLoad() {
//        loadData()
    }
    
    func createTask(title:String) { }
    func createSubtask(description: String) { }
}
