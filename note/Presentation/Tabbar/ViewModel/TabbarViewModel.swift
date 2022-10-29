//
//  TabbarViewModel.swift
//  note
//
//  Created by Thanh on 28/10/2022.
//

import Foundation


struct TabbarViewModelActions {
    var gotoSideMenu: () -> Void
    var gotoSearchView: () -> Void
    var gotoBottomSheetView: () -> Void
    var gotoLogin: () -> Void
}

protocol TabbarViewModelOutput {
    func didGotoSideMenu()
    func didGotoSearchView()
    func didGotoBottomCreate()
    func didGotoLogin()
}

protocol TabbarViewModelInput {
    
}


protocol TabbarViewModel:TabbarViewModelInput, TabbarViewModelOutput   {
    
}


final class DefaultTabbarViewModel: TabbarViewModel {
    private var actions: TabbarViewModelActions?
    
    init(actions: TabbarViewModelActions? = nil) {
        self.actions = actions
    }
    
}

extension DefaultTabbarViewModel {
    func didGotoSideMenu() {
        
    }
    
    func didGotoSearchView() {
        
    }
    
    func didGotoBottomCreate() {
        
    }
    
    func didGotoLogin() {
        actions?.gotoLogin()
    }
    
}
