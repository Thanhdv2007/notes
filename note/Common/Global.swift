//
//  Global.swift
//  note
//

//

import Foundation

class Global  {
    static let shared = Global()
    
    var loginData: UserLogin?
    
    var isLogined: Bool {
        return loginData != nil
    }
    
    init() {
        loadData()
    }
    
    func saveUser(_ user: UserLogin?) {
        self.loginData = user

        guard let user = user else {
            UserDefaults.standard.removeObject(forKey: "SavedPerson")
            return
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }

    func loadData() {
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserLogin.self, from: savedPerson) {
                self.loginData = loadedPerson
            }
        }
    }

    func logout() {
        self.saveUser(nil)
    }
}
