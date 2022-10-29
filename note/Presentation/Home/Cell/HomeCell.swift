//
//  HomeCell.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var mTime: UILabel!
    @IBOutlet weak var mDescription: UILabel!
    @IBOutlet weak var mTitle: UILabel!
    
    @IBOutlet weak var mContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configuration()
        mContent.customCorner()
        mContent.layer.shadowColor = UIColor.darkGray.cgColor
        mContent.layer.shadowOpacity = 0.4
        mContent.clipsToBounds = true
    }
    
    func configuration() {
        mContent.layer.borderColor = UIColor.gray.cgColor
        mContent.layer.cornerRadius = 10
        mContent.layer.masksToBounds = true
        mContent.clipsToBounds = true
        mContent.layer.shadowRadius = 10
        mContent.layer.shadowColor = UIColor.black.cgColor
        mContent.layer.shadowOpacity = 0.4
        
        
    }
    
    
    func fill(title:String, content: String, date: String) {
        mTime.text = date
        mTitle.text = title
        mDescription.text = content
    }

}
