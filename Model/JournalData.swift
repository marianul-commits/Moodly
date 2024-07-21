//
//  JournalData.swift
//  Moodly
//
//  Created by Marian Nasturica on 16.07.2024.
//

import SwiftUI
import SwiftData

@Model
class JournalItem {
    
    @Relationship(deleteRule: .cascade) var id: UUID = UUID()
    var title: String
    var body: String
    var date: Date = Date()
    var mood: String
    var emotions: [String]
    
    
    init(id: UUID = UUID(), title: String = "", body: String = "", date: Date = .now, mood: String = "", emotions: [String] = []) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
        self.mood = mood
        self.emotions = emotions
    }
    
    var dateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy, HH:mm"
        return dateFormatter.string(from: date)
    }
}
