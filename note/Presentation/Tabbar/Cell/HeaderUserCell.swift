//
//  HeaderUserCell.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import UIKit

class HeaderUserCell: UITableViewCell {

    @IBOutlet weak var mEmail: UILabel!
    @IBOutlet weak var mJoinDate: UILabel!
    @IBOutlet weak var mAvatar: UIImageView!
    @IBOutlet weak var mLogout: UIButton!
    
    var logout: () -> Void = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.fill()
        mLogout.setImage(UIImage(named: "ic_logout")?.withRenderingMode(.alwaysTemplate), for: .normal)
        mLogout.tintColor = .systemGray2
//
    }

    
    func fill(){
        let user = Global.shared.loginData
        mEmail.text = user?.email
        mJoinDate.text = user?.date.formatted()
    }
    
    @IBAction func onActionLogout(_ sender: Any){
        logout()
    }
}
