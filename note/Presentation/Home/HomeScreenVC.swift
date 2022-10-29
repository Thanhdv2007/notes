//
//  HomeScreen.swift
//  note
//
//

import UIKit
import SideMenu
import RealmSwift

class HomeScreenVC: BaseVC {
    
    enum HomeScreenCell: Int, CaseIterable {
        case note
        case task
    }
    
    @IBOutlet weak var mtableView: UITableView!
    var viewModel: HomeViewModel!
    
    static func create(viewModel: HomeViewModel) -> HomeScreenVC {
        let vc = HomeScreenVC()
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView(with: viewModel)
        viewModel.viewDidLoad()
        setupConfiguration()
        setupNavigation()
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupConfiguration(){
        mtableView.registerNib(HomeHorizalViewCell.self)
        
        let header = StretchyHeaderView(frame: CGRect(x: 0, y: 0,
                                                      width: view.frame.size.width,
                                                      height: view.frame.size.width / 2))
        header.imageView.image = UIImage(named: "img_header")
        header.imageView.backgroundColor = .red
        mtableView.tableHeaderView = header
    }
    
    func setupNavigation() {
        // upgrade view
        let menuBtn = UIButton(type: .custom)
        let backBtnImage = UIImage(named: "ic_features")
        menuBtn.setBackgroundImage(backBtnImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(updateFuture), for: .touchUpInside)
        menuBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.addSubview(menuBtn)
        
        let menuBtn2 = UIButton(type: .custom)
        let imageEdit = UIImage(named: "ic_home_edit")
        menuBtn2.setBackgroundImage(imageEdit, for: .normal)
        menuBtn2.addTarget(self, action: #selector(updateFuture), for: .touchUpInside)
        menuBtn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menuBtn2View = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuBtn2View.addSubview(menuBtn2)
        
        let backButton = UIBarButtonItem(customView: view)
        let editHome = UIBarButtonItem(customView: menuBtn2View)

        navigationItem.rightBarButtonItems = [editHome,backButton]
        
    }
    
    func bindView(with viewModel: HomeViewModel) {
       
//        notes = user.lists.where({ $0.typeNode == .note})
//        notificationTokenForCustomArrayList = notes.observe {  changes in
//            switch changes {
//            case .initial:
//                break
//            case .update(_, let deletions, let insertions, let modifications):
//                self.mtableView.performBatchUpdates { [weak self] in
//                    guard let self = self else { return }
//                    self.mtableView.reloadRows(at: modifications.map({_ in IndexPath(row: 0, section: 0) }),
//                                                  with: .automatic)
//                } completion: { finished in
//                    // ...
//                }
//            case .error(let error):
//                fatalError("\(error)")
//            }
//        }
        updateTableView()
    }
    
    
    @objc func editLayoutHome(){
        
    }
    
    @objc func updateFuture(){
        
    }
    
    func updateTableView(){
        mtableView.reloadData()
    }
   
}

extension HomeScreenVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeScreenCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == HomeScreenCell.task.rawValue {
            let cell = tableView.dequeue(cell: HomeHorizalViewCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.fillData(type: .task )
            return cell
        } else if indexPath.section == HomeScreenCell.note.rawValue {
            let cell = tableView.dequeue(cell: HomeHorizalViewCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.fillData(type: .note)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let sectionBtn = UIButton(type: .custom)
        if section == HomeScreenCell.task.rawValue {
            sectionBtn.setTitle("Nhiệm vụ", for: .normal)
        } else if section == HomeScreenCell.note.rawValue {
            sectionBtn.setTitle("Ghi Chú", for: .normal)
        }
        sectionBtn.setTitleColor(.systemGray, for: .normal)
        sectionBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        sectionBtn.semanticContentAttribute = .forceRightToLeft
        sectionHeader.addSubview(sectionBtn)
        sectionBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionBtn.leftAnchor.constraint(equalTo: sectionHeader.leftAnchor,constant: 6),
            sectionBtn.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor,constant: 0),
        ])
        return sectionHeader
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = mtableView.tableHeaderView as? StretchyHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
    
}
