//
//  HomeHorizalViewCell.swift
//  note
//
//

import UIKit
import RealmSwift

class HomeHorizalViewCell: UITableViewCell {
 
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var mMsg: UILabel!
    
    var tasks: Results<TaskModelDTO>?
    private var notificationTokenForCustomArrayList: NotificationToken?
    var typeView: TypeNote = .note
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configuration()
    }
    
    func configuration() {
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.registerNib(HomeCell.self)
    }
    
    func fillData(type: TypeNote ) {
        self.typeView = type
        guard let currentUser = Global.shared.loginData else  {
            return
        }
        guard let user = RealmManager.shared.realm.objects(UserModelDTO.self).where({ $0.email == currentUser.email}).first else  {
            return
        }
        tasks = user.lists.where({ $0.typeNode == type})
        notificationTokenForCustomArrayList = tasks?.observe {  changes in
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self.mCollectionView.performBatchUpdates { [weak self] in
                    guard let self = self else { return }
                    self.mCollectionView.reloadSection(0)
                } completion: { finished in
                    // ...
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
        if tasks?.count == 0 {
            mCollectionView.isHidden = true
            if type == .note {
                mMsg.text = "Bạn chưa có ghi chú nào"
            } else {
                mMsg.text = "Bạn chưa có nhiệm vụ nào"
            }
            return
        }
        mMsg.isHidden = true
        
        mCollectionView.reloadData()
    }
}
extension HomeHorizalViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (tasks?.count ?? 0) > 10 ? 10 : (tasks?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: HomeCell.self, at: indexPath)
        let taskDetail = tasks?[indexPath.row]
        cell.fill(title: taskDetail?.title ?? "", content: taskDetail?.descript ?? "", date: taskDetail?.dateString.formatted() ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let title = tasks?[indexPath.row] else {
            return
        }
        switch self.typeView {
        case .note:
            let vc = NotesVC()
            vc.currentNote = title
            vc.hidesBottomBarWhenPushed = true
            UIApplication.getMostTopViewController()?.navigationController?.pushViewController(vc, animated: true)
        case .task:
          
            let vc = SubtasksVC()
            vc.titleTask = title.title
            vc.hidesBottomBarWhenPushed = true
            UIApplication.getMostTopViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
