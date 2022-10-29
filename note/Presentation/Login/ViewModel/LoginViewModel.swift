//
//  LoginViewModel.swift
//  note
//
//

import Foundation

struct LoginViewModelActions {
    var gotoHome: () -> Void
    var gotoRegister: (String) -> Void
}

protocol LoginViewModelInput{
    func viewDidload()
    func didSelectLogin()
    func didSelectRegister(email: String)
}


protocol LoginViewModelOutput{
    var user: Observable<UserModelDTO?> { get  }
}

protocol LoginViewModel: LoginViewModelInput,LoginViewModelOutput  { }


final class DefaultLoginViewModel : LoginViewModel {
    private let getUser: LoginGetUC
    private let action: LoginViewModelActions?
    
    internal var user: Observable<UserModelDTO?> = Observable(nil)
    
    init(getUser: LoginGetUC, action: LoginViewModelActions? = nil) {
        self.getUser = getUser
        self.action = action
    }
    
    
}
extension DefaultLoginViewModel {
    
    func viewDidload() {
        
    }
    
    func didSelectLogin() {
        
    }
    
    func didSelectRegister(email:String) {
        action?.gotoRegister(email)
    }
    
}
