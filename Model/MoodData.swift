//
//  MoodData.swift
//  Moodly
//
//  Created by Marian Nasturica on 21.07.2024.
//

import SwiftUI
import SwiftData

@Model
class MoodItem {
    @Relationship(deleteRule: .cascade) var date: Date
    var morningMood: String
//    var afternoonMood: String
//    var eveningMood: String
    var morningColor: String
//    var afternoonColor: String
//    var eveningColor: String
    
    init(date: Date, morningMood: String, morningColor: String) {
        self.date = date
        self.morningMood = morningMood
        self.morningColor = morningColor
    }
    
//    init(date: Date = Date(), morningMood: String = "", afternoonMood: String = "", eveningMood: String = "", morningColor: String = "", afternoonColor: String = "", eveningColor: String = "") {
//        self.date = date
//        self.morningMood = morningMood
//        self.afternoonMood = afternoonMood
//        self.eveningMood = eveningMood
//        self.morningColor = morningColor
//        self.afternoonColor = afternoonColor
//        self.eveningColor = eveningColor
//    }
}
