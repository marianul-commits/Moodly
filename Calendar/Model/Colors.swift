//
//  Colors.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

class Colors: ObservableObject {

    //Foreground
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.blue
    @Published var disabledColor: Color = Color.gray
    @Published var selectedColor: Color = Color.primary

    //Background
    @Published var backgroundColor: Color = Color.clear
    @Published var weekdayBackgroundColor: Color = Color.clear
    @Published var selectedBackgroundColor: Color = Color.orange

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
