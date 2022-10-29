//
//  CreateTaskView.swift
//  note
//
//  Created by Thanh on 29/10/2022.
//

import UIKit

class CreateTaskView: UIViewController {

    @IBOutlet weak var mTftTitleTask: UITextField!
    
   public var performString: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGes)
        // Do any additional setup after loading the view.
        mTftTitleTask.delegate = self
        mTftTitleTask.becomeFirstResponder()
    }

    
    @objc func dismissView(){
        dismiss(animated: true)
    }
    
    @IBAction func onActionDetailView(_ sender: Any) {
        guard let text = mTftTitleTask.text else {
            return
        }
        dismiss(animated: false) {
            self.performString?(text)
        }
    }
}

extension CreateTaskView: UITextFieldDelegate {
    
}
