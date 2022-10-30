//
//  UIButton+Ext.swift
//  note
//
//

import UIKit

extension UIButton {
    func btnCapsule() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
