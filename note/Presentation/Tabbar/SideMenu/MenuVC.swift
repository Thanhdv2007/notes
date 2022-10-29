//
//  MenuVC.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import UIKit

class MenuVC: UIViewController {
    
    enum MenuType:Int, CaseIterable {
        case infoUser = 0
        case upgradeVip
        case listMenu
    }
    
    enum PerformActions {
        case logout
        case upgrade
        case indexMenu(Int)
    }

    @IBOutlet var mTblMenu: UITableView!
    var listMenu = ["Home", "Shortcuts", "Notes", "Tasks"]
    var iconMenu = ["house", "star.fill", "note.text", "list.bullet.rectangle.portrait"]
    
    public var performs: (PerformActions) -> Void = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    

    func configuration() {
        mTblMenu.registerNib(HeaderUserCell.self, UpgradeCell.self, MenuCell.self)
        mTblMenu.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        mTblMenu.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuType.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == MenuType.infoUser.rawValue {
           return 1
        } else if section == MenuType.upgradeVip.rawValue {
            return 1
        } else if section == MenuType.listMenu.rawValue {
            return listMenu.count
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == MenuType.infoUser.rawValue {
            let cell = tableView.dequeue(cell: HeaderUserCell.self, at: indexPath)
            cell.logout = {[weak self] in
                Global.shared.logout()
                let loginDI = appDIContainer.makeLoginSceneDIContainer()
                let loginVC = loginDI.makeLoginCoordinator().visible()
                self?.present(loginVC, animated: false)
            }
            cell.selectionStyle  = .none
            return cell
        } else if indexPath.section == MenuType.upgradeVip.rawValue {
            let cell = tableView.dequeue(cell: UpgradeCell.self, at: indexPath)
            cell.cbUpgrade = {
                self.performs(.upgrade)
            }
            cell.selectionStyle  = .none
            return cell
        } else if indexPath.section == MenuType.listMenu.rawValue {
            let cell = tableView.dequeue(cell: MenuCell.self, at: indexPath)
            cell.fill(icon: UIImage(systemName: iconMenu[indexPath.row]) ?? UIImage(), title: listMenu[indexPath.row] )
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row  == MenuType.infoUser.rawValue {
            return 44
         } else if indexPath.row  == MenuType.upgradeVip.rawValue {
             return UITableView.automaticDimension
         } else if indexPath.row  == MenuType.listMenu.rawValue {
             return 44
         }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == MenuType.listMenu.rawValue {
            performs(.indexMenu(indexPath.row))
        } else {
            tableView.selectionFollowsFocus = false
        }
    }
    
    
}
