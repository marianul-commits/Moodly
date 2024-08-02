//
//  DayCellView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct DayCellView: View {
    @ObservedObject var moodModelController: MoodModelController
    @ObservedObject var day: Day
    
    var body: some View {
        VStack {
            Text(day.dayName).frame(width: 32, height: 32)
                .foregroundColor(day.textColor)
                .clipped()
            moodText()
        }
        .background(day.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            if self.day.disabled == false && self.day.selectableDays {
                self.day.isSelected.toggle()
            }
        }
    }
    
    func moodText() -> some View {
        let moodGradient = getMoodGradient(for: day, moodModelController: moodModelController)

        return Capsule()
            .fill(moodGradient)
            .frame(width: 20, height: 10)
    }
    
    func getMoodGradient(for day: Day, moodModelController: MoodModelController) -> LinearGradient {
        let colors = Colors()
        var moodColors: [Color] = []

        for m in moodModelController.moods {
            if m.monthString == day.monthString && m.dayAsInt == day.dayAsInt && m.year == day.year {
                if let color = colors.moodColors[m.emotion.state.rawValue] {
                    moodColors.append(color)
                }
            }
        }

        if moodColors.isEmpty {
            moodColors = [Color.clear] // Use default color if no moods found
        }

        return LinearGradient(gradient: Gradient(colors: moodColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

#Preview {
    DayCellView(moodModelController: MoodModelController(), day: Day(date: Date()))
}
