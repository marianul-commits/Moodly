//
//  UserManager.swift
//  Moodly
//
//  Created by Marian Nasturica on 05.08.2024.
//

import Foundation

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool
    
    init() {
        self.isLoggedIn = UserDefaults.standard.string(forKey: "username") != nil
    }
    
    func login(username: String) {
        UserDefaults.standard.set(username, forKey: "username")
        isLoggedIn = true
    }
}
