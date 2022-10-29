//
//  CreateSubTaskView.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit

class CreateSubTaskView: UIViewController {

    @IBOutlet weak var mTftTask: UITextField!
    @IBOutlet weak var mCheckbox: UIView!
    @IBOutlet weak var mSubmut: UIButton!
    
    var checkBox: CheckBox?
    var callBack: ((SubTaskModelDTO) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGes)
        
        configuration()
    }
    func configuration(){
        checkBox = CheckBox(view: mCheckbox, style: .oval)
        checkBox?.create(size: .small , center: CGPoint(x: 0, y: 0))
        checkBox?.animation = .normal
        checkBox?.callBackState = { state in
            print("callBackState", state)
        }
    }
    
    
    @objc func dismissView(){
        dismiss(animated: true)
        saveTask()
    }

    @IBAction func onActionSubbmit(_ sender: Any) {
        dismissView()
    }
    
    func saveTask() {
        guard let text = mTftTask.text else {
            return
        }
        let subtask = SubTaskModelDTO()
        subtask.title = text
        subtask.isComplete = checkBox?.state ?? false
        callBack?(subtask)
    }
}
