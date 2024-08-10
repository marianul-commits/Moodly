//
//  Colors.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

class Colors: ObservableObject {

    //Foreground
    @Published var textColor: Color = Color.brandText
    @Published var todayColor: Color = Color.brandGreen
    @Published var disabledColor: Color = Color.brandGray
    @Published var selectedColor: Color = Color.brandText

    //Background
    @Published var backgroundColor: Color = Color.clear
    @Published var weekdayBackgroundColor: Color = Color.clear
    @Published var selectedBackgroundColor: Color = Color.brandPrimary

}

extension Colors {
    var moodColors: [String: Color] {
        return [
            "happy": .yellow,
            "relaxed": .purple,
            "anxious": .green,
            "sad": .blue,
            "angry": .red
        ]
    }
}
