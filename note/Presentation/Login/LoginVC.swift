//
//  LoginVC.swift
//  note
//
//

import UIKit

class LoginVC: BaseVC {
    
    enum CaseLogin {
        case email
        case password
    }
    
    @IBOutlet var mTfInput: UITextField!
    @IBOutlet var mBtnContinue: UIButton!
    @IBOutlet weak var mLblError: UILabel!
    
    var caseLogin: CaseLogin = .email
    var viewModel: LoginViewModel!
    
    static func create(with viewModel: LoginViewModel) -> LoginVC {
        let vc =  LoginVC()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
    
    func configuration(){
        mTfInput.useUnderline()
    }
    
    
    @IBAction func onActionContinue(_ sender: Any){
        print("onActionContinue")
        guard let email = mTfInput.text, !email.isEmpty  else {
            mLblError.text = "Không được để trống Email"
            return
        }
        mLblError.text = ""
        viewModel.didSelectRegister(email: email)
    }
}
