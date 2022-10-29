//
//  MainTabbarController.swift
//  note
//
//  Created by Thanh on 28/10/2022.q
//

import UIKit
import SideMenu


class MainTabController: UITabBarController {
    
    static func create(with viewModel: TabbarViewModel) -> MainTabController {
        let tabbar = MainTabController()
        tabbar.viewModel = viewModel
        return tabbar
    }
    
    var menu: SideMenuNavigationController?
    private var viewModel: TabbarViewModel!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.backgroundColor = .systemGray6
        
        setupView()
        setupSideMenu()
        
        selectedIndex = 1
    }
    
    func setupView(){
        
        let homeDependencies = appDIContainer.makeHomeSceneDIContainer()
        let homeVC = homeDependencies.makeHomeCoordinator().visible(self)
        homeVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        
        let login = appDIContainer.makeLoginSceneDIContainer()
        let loginVC =  login.makeLoginCoordinator().visible()
        loginVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_search"), selectedImage: UIImage(named: "ic_search"))
        
        
        let sVC = SViewController()
        sVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_menu"), selectedImage: UIImage(named: "ic_menu"))
        

        
        let viewControllers = [sVC,homeVC, loginVC]
        self.setViewControllers(viewControllers, animated: false)
        
        
        guard let tabBar = self.tabBar as? CustomTabBar else {
            return }
        
        tabBar.didTapButton = { [unowned self] in
            self.routeToCreateNewAd()
        }
    }
    
    func setupSideMenu(){
        let menuVc = MenuVC()
        menuVc.performs = { [weak self] actionMenu in
            switch actionMenu {
            case .logout:
                return
            case .upgrade:
                guard let view =  self?.viewControllers?.first as? BaseVC else {
                    return
                }
                view.showAlert(message: "Chức năng đang được bổ sung")
                return
            case .indexMenu(let index):
                switch index {
                case 0:
                    self?.selectedIndex = 0
                default: break
                }
                break
            }
            self?.menu?.dismiss(animated: true)
        }
//        MenuVC
        menu = SideMenuNavigationController(rootViewController: MenuVC())
        menu?.leftSide = true
        var setting = SideMenuSettings()
        setting.presentationStyle = .menuSlideIn
        menu?.settings = setting
        SideMenuManager.default.leftMenuNavigationController = menu
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
  
    
    func routeToCreateNewAd() {
        let modalVC = ModelCreateView()
        modalVC.perForm = { screen in
            switch screen {
            case .task:
                let vc = CreateTaskView()
                vc.performString = { title in
                    let vc = SubtasksVC()
                    vc.titleTask = title
                    vc.modalPresentationStyle = .overFullScreen
                    self.viewControllers?.first?.navigationController?.pushViewController(vc, animated: true)
                }
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false, completion:  nil)
            case .note:
                let vc = NotesVC()
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        modalVC.modalPresentationStyle = .overCurrentContext
        self.present(modalVC, animated: true, completion:  nil)
    }
}

extension MainTabController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        if viewController is SViewController {
            self.present(menu!,animated: true)
            return false
        }
        if tabBarController.selectedIndex == 1 {
            return false
        }

        return true
    }
}
// MARK: - View Controllers
class SViewController: UIViewController {
    override func viewDidLoad() {
        navigationItem.title = "Home"
    }
}
