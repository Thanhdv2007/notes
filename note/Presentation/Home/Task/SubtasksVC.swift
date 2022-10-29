//
//  SubtasksVC.swift
//  note
//
//

import UIKit
import RealmSwift
import Toast_Swift

class SubtasksVC: UIViewController {

    @IBOutlet weak var mTblCreateSubtask: UIButton!
    @IBOutlet weak var mTblView: UITableView!
    @IBOutlet weak var msgEmpty: UILabel!
    
    var listSubTaskModel = List<SubTaskModelDTO>()
    private var notificationTokenForCustomArrayList: NotificationToken?
    var titleTask: String = ""
    var currentNote: TaskModelDTO = TaskModelDTO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleTask
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        mTblCreateSubtask.customCorner()
        configuration()
    }
    
    private func configuration() {
        mTblView.registerNib(SubTaskCell.self)
        getTask()
    }
    
    
    func getTask(){
        guard let currentUser = Global.shared.loginData else  {
            return
        }
        guard let user = RealmManager.shared.realm.objects(UserModelDTO.self).where({ $0.email.equals(currentUser.email)}).first else  {
            return
        }
        guard let task = user.lists.where({ [self] in $0.typeNode == .task && $0.title == titleTask }).first else {
            let task = TaskModelDTO()
            task.title = self.titleTask
            task.typeNode = .task
            RealmManager.shared.saveTaskToInfo(list: task, in: user)
            return
        }
        self.currentNote = task
        listSubTaskModel = task.subTask
        notificationTokenForCustomArrayList = listSubTaskModel.observe {  changes in
            switch changes {
            case .initial:
                break
            case .update(_,let deletions, let insertions, let modifications):
                self.mTblView.performBatchUpdates { [weak self] in
                    guard let self = self else { return }
                    self.mTblView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                                  with: .automatic)
                    self.mTblView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                    self.mTblView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                } completion: { finished in
                    // ...
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
        if (listSubTaskModel.count) == 0 {
            msgEmpty.text = "Bạn chưa có nhiệm vụ nào"
            mTblView.isHidden = true
        }
        msgEmpty.isHidden = true
     
        mTblView.reloadData()
    }

    @IBAction func onAddTask(_ sender: Any) {
        let create = CreateSubTaskView()
        create.callBack = { create in
            // update note
            RealmManager.shared.saveSubtask(task: create, in: self.currentNote)
        }
        create.modalPresentationStyle = .overCurrentContext
        self.present(create, animated: true)
    }
}

extension SubtasksVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listSubTaskModel.count
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = listSubTaskModel[indexPath.row]
        
        let cell = tableView.dequeue(cell: SubTaskCell.self, at: indexPath)
        cell.fill(subTask: row)
        cell.callBackState = { stateSuccess in
            RealmManager.shared.updateSucces(in: row)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
