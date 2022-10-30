//
//  NotesVC.swift
//  note
//
//  Created by Thanh on 30/10/2022.
//

import UIKit
import MultilineTextField
import IQKeyboardManagerSwift

class NotesVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var mTitle: UITextField!
    @IBOutlet weak var viewEditor: UITextView!
  
    var currentNote:TaskModelDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTitle.delegate = self
        mTitle.becomeFirstResponder()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        if currentNote != nil {
            mTitle.text = currentNote!.title
            mTitle.resignFirstResponder()
            viewEditor.becomeFirstResponder()
            viewEditor.text = currentNote?.descript
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        super.viewDidDisappear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let title = mTitle.text, let description = viewEditor.text else {
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
        note.title = !title.isEmpty ? title : viewEditor.text ?? currentNote?.descript ?? ""
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
            viewEditor.becomeFirstResponder()
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
