//
//  SubTaskCell.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit
import DLRadioButton

class SubTaskCell: UITableViewCell {

    @IBOutlet weak var mBtnChecked: DLRadioButton!
//        @IBOutlet weak var mCheck: UIView!
    @IBOutlet weak var mTitleSubtask: UILabel!
    @IBOutlet weak var mDesription: UILabel!
    @IBOutlet weak var mIsFavorite: UIButton!
    
    @IBOutlet weak var view: UIView!
    var isFavorite = false
    var checkbox: CheckBox?
    
    var callBackState: ((Bool) -> Void)?
    var subTask: SubTaskModelDTO = SubTaskModelDTO()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configuration()
    }
    
    func configuration(){
        view.customCorner()
    }
    
    func fill(subTask: SubTaskModelDTO) {
        self.subTask = subTask
        print("date \(Date()) -> subTask.isComplete \(subTask.isComplete)")
        mBtnChecked.isSelected = subTask.isComplete
        mDesription.text = subTask.dateString.formatted()
        mTitleSubtask.text = subTask.title
    }
    @IBAction func mActionChecked(_ sender: Any) {
        mBtnChecked.isSelected.toggle()
        RealmManager.shared.updateSucces(in: self.subTask)
    }
    
    @IBAction func onActionFavorite(_ sender: Any) {
        isFavorite.toggle()
        mIsFavorite.setImage(UIImage(systemName: isFavorite ? "star.fill" : "star"), for: .normal)
    }
}
