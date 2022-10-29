//
//  UIView+Ext.swift
//  note
//
//  Created by Thanh on 29/10/2022.
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
