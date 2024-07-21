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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalItem.self)
    }
}
