//
//  MenuCell.swift
//  note
//
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var mIcon: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fill(icon: UIImage, title: String){
        mIcon.image = icon
        mTitle.text = title
    }
    
}
