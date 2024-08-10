//
//  MoodlyApp.swift
//  Moodly
//
//  Created by Marian Nasturica on 10.07.2024.
//

import SwiftUI
import SwiftData

@main
struct MoodlyApp: App {
    @StateObject private var userManager = UserManager()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            if userManager.isLoggedIn {
                ContentView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LoginPage(userManager: userManager)
            }
        }
        .modelContainer(for: JournalItem.self)
    }
}
