//
//  Constants.swift
//  Moodly
//
//  Created by Marian Nasturica on 13.07.2024.
//

import UIKit
import SwiftUI

// Get UI Screen size
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

// Struct to set fonts easier
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

// TabBar enum

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case calendar
    case journal
    case settings
}

// Calendar extensions

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
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
