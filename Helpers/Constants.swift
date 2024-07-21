//
//  Constants.swift
//  Moodly
//
//  Created by Marian Nasturica on 13.07.2024.
//

import UIKit
import SwiftUI

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}


struct DayInfo: Identifiable {
    var id = UUID()
    var dayName: String
    var date: String
    var isToday: Bool
    var isPast: Bool
    var isFuture: Bool
}


func getLast7Days() -> [DayInfo] {
    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "EEEEE"

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"

    let calendar = Calendar.current
    var dates = [DayInfo]()
    
    for i in -3...3 {
        if let date = calendar.date(byAdding: .day, value: i, to: Date()) {
            let dayString = dayFormatter.string(from: date)
            let dateString = dateFormatter.string(from: date)
            let isToday = calendar.isDateInToday(date)
            let isPast = i < 0
            let isFuture = i > 0
            dates.append(DayInfo(dayName: dayString, date: dateString, isToday: isToday, isPast: isPast, isFuture: isFuture))
        }
    }
    
    return dates
}

struct SetFont {
    
    enum FontStyle {
        case regular
        case bold
        case medium
        case thinItalic
        case semibold
        case thin
        
    }
    
    static func setFontStyle(_ style: FontStyle, _ size: CGFloat) -> Font {
        switch style {
        case .regular:
            return Font.custom("PPPangramSans-CompactRegular", size: size)
        case .thin:
            return Font.custom("PPPangramSans-Thin", size: size)
        case .medium:
            return Font.custom("PPPangramSans-Medium", size: size)
        case .bold:
            return Font.custom("PPPangramSans-Bold", size: size)
        case .thinItalic:
            return Font.custom("PPPangramSans-CompactThinItalic", size: size)
        case .semibold:
            return Font.custom("PPPangramSans-Semibold", size: size)
        }
    }
}

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case calendar
    case journal
    case settings
}


struct DailyMoods: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    var items: [DailyMoods]?

    static let happy = DailyMoods(name: "Happy", color: .yellow)
    static let relaxed = DailyMoods(name: "Relaxed", color: .purple)
    static let anxious = DailyMoods(name: "Anxious", color: .green)
    static let sad = DailyMoods(name: "Sad", color: .blue)
    static let anger = DailyMoods(name: "Anger", color: .red)
    
    static let list = DailyMoods(name: "Legend", color: .black, items: [DailyMoods.anger, DailyMoods.sad, DailyMoods.anxious, DailyMoods.relaxed, DailyMoods.happy])
    
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
