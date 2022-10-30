//
//  ModelCreateView.swift
//  note
//
//

import UIKit

class ModelCreateView: UIViewController {

    @IBOutlet weak var mBtnNote: UIButton!
    @IBOutlet weak var mBtnTask: UIButton!
    @IBOutlet weak var model: UIView!
    
    var perForm: ((TypeNote) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGes)
        model.customCorner()
        let height = mBtnTask.frame.size.height / 2
        mBtnTask.customCorner(radius: height)
        mBtnNote.customCorner(radius: height)
    }

    @objc func dismissView(){
        self.dismiss(animated: true)
    }
    
    @IBAction func onActionCreateTask(_ sender: Any) {
        self.dismiss(animated: false)
        perForm?(.task)
    }
    
    @IBAction func onActionCreateNote(_ sender: Any) {
        self.dismiss(animated: false) {
            self.perForm?(.note)
        }
        
    }
    
}
