//
//  HeaderView.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit

class HeaderView: UIView {


    @IBOutlet var mView: UIView!
    @IBOutlet weak var mTitle: UIButton!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    
    private func commonInit() {
        Bundle.main.loadNibNamed(HeaderView.identifier, owner: self, options: nil)
        addSubview(mView)
        mView.frame = self.bounds
        mView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func onActionShowDetail(_ sender: Any) {
        
    }
}
