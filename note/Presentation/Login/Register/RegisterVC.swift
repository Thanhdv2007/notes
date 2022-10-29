//
//  RegisterVC.swift
//  note
//
//

import UIKit

class RegisterVC: BaseVC {
    
    
    @IBOutlet weak var mTftEmail: UITextField!
    @IBOutlet weak var mBtnForgotPassword: UIButton!
    @IBOutlet weak var mTftPassword: UITextField!
    @IBOutlet weak var mBtnLogin: UIButton!
    
    private var viewModel: RegisterViewModel!
    
    static func create(with viewModel: RegisterViewModel) -> RegisterVC{
        let vc = RegisterVC()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        bindView(with: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mTftEmail.text = viewModel.email
    }
    
    func configuration(){
        mTftEmail.useUnderline()
        mTftPassword.useUnderline()
        
    }
    
    func bindView(with viewModel: RegisterViewModel) {
        viewModel.error.observe(on: self) { err in
            guard err != nil  else {
                return
            }
            self.showAlert(message: err! )
        }
    }
    
    
    @IBAction func onActionForgotPassword(_ sender: Any) {
        
    }
    
    
    @IBAction func onActionLogin(_ sender: Any) {
        viewModel.login(email: mTftEmail.text, password: mTftPassword.text)
    }
}
