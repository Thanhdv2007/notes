//
//  RadioChecked.swift
//  note
//
//

import Foundation
import SwiftUI
class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        super.awakeFromNib()
    }

    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }

    func toggleButton(){
        self.isSelected = !isSelected
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(named: "ic_radio_check"), for: .normal)
            } else {
                self.setImage(UIImage(named: "ic_radio_uncheck"), for: .normal)
            }
            
        }
    }
}
