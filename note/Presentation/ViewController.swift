//
//  ViewController.swift
//  note
//
//

import UIKit

let appDIContainer = AppDIContainer()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Global.shared.isLogined {
            let loginDI = appDIContainer.makeTabbarMainDIContainer()
            let loginVC = loginDI.makeTabbarCoordinator().visible()
            loginVC.navigationController?.navigationBar.isTranslucent = true
            loginVC.navigationController?.navigationBar.shadowImage = nil
            loginVC.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
            self.present(loginVC, animated: false)
            return
        }
        let loginDI = appDIContainer.makeLoginSceneDIContainer()
        let loginVC = loginDI.makeLoginCoordinator().visible()
        self.present(loginVC, animated: false)
    }


}

