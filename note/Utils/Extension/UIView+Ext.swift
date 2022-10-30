//
//  UIView+Ext.swift
//  note
//
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func customCorner(radius: Double = 12){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
