//
//  UITextField+Ext.swift
//  note
//

import UIKit


extension UITextField {
    func useUnderline(color: UIColor = .black) -> Void {
      let border = CALayer()
      let borderWidth = CGFloat(1.0) // Border Width
      border.borderColor = color.cgColor
      border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
      border.borderWidth = borderWidth
      self.layer.addSublayer(border)
      self.layer.masksToBounds = true
    }
}
