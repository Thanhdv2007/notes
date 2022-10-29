//
//  ListNotesCell.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import UIKit

class ListNotesCell: UITableViewCell {

    @IBOutlet weak var mDate: UILabel!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(icon: UIImage, title: String, date: String){
        mDate.text = date
        mTitle.text = title
        mIcon.image = icon
    }
    
}
