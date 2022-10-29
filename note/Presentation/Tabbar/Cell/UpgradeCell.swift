//
//  UpgradeCell.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import UIKit

class UpgradeCell: UITableViewCell {

    @IBOutlet weak var mUpgrade: UIButton!
    public var cbUpgrade: () -> Void = { }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mUpgrade.configuration = .bordered()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onActionUpgrade(_ sender: Any) {
        cbUpgrade()
    }
}
