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

func getLast7Days() -> [Day] {
    let calendar = Calendar.current
    var days = [Day]()
    
    for i in -3...3 {
        if let date = calendar.date(byAdding: .day, value: i, to: Date()) {
            let isToday = calendar.isDateInToday(date)
            let isPast = i < 0
            let isFuture = i > 0
            let day = Day(date: date, today: isToday, disable: !isPast && !isFuture, selectable: true)
            days.append(day)
        }
    }
    
    return days
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

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

// From Color to Hex
extension Color {
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}

// From Hex to Color
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

extension Date {

    func dateToString(format: String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let dateString = dateFormat.string(from: self)
        return dateString
    }
}


extension String {

    func stringToDate(format: String) -> Date {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let date = dateFormat.date(from: self)!
        return date
    }

}
