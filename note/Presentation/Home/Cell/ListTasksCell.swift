//
//  ListTasksCell.swift
//  note
//
//

import UIKit

class ListTasksCell: UITableViewCell {

    @IBOutlet weak var mLblTitleTask: UILabel!
    @IBOutlet weak var mIcIcon: UIImageView!
    
    @IBOutlet weak var mDate: UILabel!
    @IBOutlet weak var mNumberTask: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(icon: UIImage, title: String, date: String, numberTask: String){
        mDate.text = date
        mLblTitleTask.text = title
        mIcIcon.image = icon
        mNumberTask.text = numberTask
        
    }
}
