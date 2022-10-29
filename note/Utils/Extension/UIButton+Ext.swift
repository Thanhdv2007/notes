//
//  UIButton+Ext.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit

extension UIButton {
    func btnCapsule() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
