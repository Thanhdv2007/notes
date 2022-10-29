//
//  NotesVC.swift
//  note
//
//  Created by Thanh on 30/10/2022.
//

import UIKit
import MultilineTextField

class NotesVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var mTitle: UITextField!
    @IBOutlet weak var viewEditor: UIView!
  
    var textField: MultilineTextField?
    var currentNote:TaskModelDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTitle.delegate = self
        mTitle.becomeFirstResponder()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        textField = MultilineTextField(frame: viewEditor.bounds)
        // below are properties that can be optionally customized
        textField?.placeholder =  "Bắt đầu viết"
        textField?.placeholderColor = UIColor.gray
        textField?.isPlaceholderScrollEnabled = true
        textField?.delegate = self
        
        textField?.leftViewOrigin = CGPoint(x: 8, y: 8)
        viewEditor.addSubview(textField ?? MultilineTextField())
        if currentNote != nil {
            mTitle.text = currentNote!.title
            textField?.becomeFirstResponder()
            textField?.text = currentNote?.descript
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let title = mTitle.text, let description = textField?.text else {
            super.viewWillDisappear(animated)
            return
        }
        
        guard let currentUser = Global.shared.loginData else  {
            super.viewWillDisappear(animated)
            return
        }
        guard let user = RealmManager.shared.realm.objects(UserModelDTO.self).where({ $0.email.equals(currentUser.email)}).first else  {
            super.viewWillDisappear(animated)
            return
        }
        
        let note = TaskModelDTO()
        note.title = !title.isEmpty ? title : textField?.text ?? currentNote?.descript ?? ""
        note.descript = description
        note.typeNode = .note
        
        if self.currentNote != nil {
            print("self.currentNote")
            RealmManager.shared.updateTask(task: self.currentNote!, updatingTask: note)
        }else {
            RealmManager.shared.saveTaskToInfo(list: note, in: user)
        }
        super.viewWillDisappear(animated)
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mTitle{
            mTitle.resignFirstResponder()
            self.textField?.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            let position = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }
}
