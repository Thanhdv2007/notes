//
//  RegisterViewModel.swift
//  note
//
//

import Foundation

struct RegisterViewModelActions {
    var gotoLogin: () -> Void
    var gotoHome: () -> Void
}

protocol RegisterViewModelInput {
    func viewDidload()
    func didSelectLogin()
    func login(email: String?, password: String?)
}

protocol RegisterViewModelOutput{
    var user: Observable<UserModelDTO?> { get  }
    var email: String { get set}
    var error: Observable<String?> { get }
}

protocol RegisterViewModel:RegisterViewModelInput, RegisterViewModelOutput {
    
}

final class DefaultRegisterViewModel: RegisterViewModel {
    
    var user: Observable<UserModelDTO?> = Observable(nil)
    private let saveUC: LoginSaveUC
    private let getUC: LoginGetUC
    private let action: RegisterViewModelActions?
    var email: String
    
    let error: Observable<String?> = Observable(nil)
    
    
    init(userLogin: String, getUC: LoginGetUC, saveUC: LoginSaveUC,action: RegisterViewModelActions? = nil) {
        self.email = userLogin
        self.saveUC = saveUC
        self.getUC = getUC
        self.action = action
    }
}

extension DefaultRegisterViewModel {
    func viewDidload() {
        
    }
    
    func didSelectLogin() {
        action?.gotoLogin()
    }
    
    func login(email: String?, password: String?) {
        guard email != nil else {
            error.value  = "Email không được để rỗng"
            return
        }
        guard email == self.email else {
            error.value  = "Email Khác Với email cũ"
            return
        }
        
        guard password != nil else {
            error.value  = "Mật khẩu không được để rỗng"
            return
        }
        getUC.execute(email: email!) {[weak self] result in
            switch result {
            case .success(let user):
                if let userCurrent = user  {
                    if userCurrent.password == password! {
                        let user = userCurrent.toDomain()
                        Global.shared.saveUser(user)
                        self?.action?.gotoHome()
                    } else {
                        self?.error.value = "Sai mật khẩu"
                    }
                } else {
                    self?.saveUser(userLogin: UserLogin(email: email!, password: password!))
                }
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
        
    }
    
    func saveUser(userLogin: UserLogin){
        saveUC.execute(user: userLogin) {[weak self] results  in
            switch results {
            case .failure(let error):
                self?.error.value = error.localizedDescription
            case .success(_):
                self?.getUC.execute(email: userLogin.email) {[weak self] result in
                    switch result {
                    case .success(let user):
                        let user = user?.toDomain()
                        Global.shared.saveUser(user)
                        self?.action?.gotoHome()
                    case .failure(let error):
                        self?.error.value = error.localizedDescription
                    }
                }
                break
                
            }
        }
    }
}
