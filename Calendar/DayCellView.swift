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
            //            .background(day.backgroundColor)
            //  .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
            //            .onTapGesture {
            //                if self.day.disabled == false && self.day.selectableDays {
            //                    self.day.isSelected.toggle()
            //                }
            //        }
            
            moodText()
            
        }.background(day.backgroundColor).clipShape(RoundedRectangle(cornerRadius: 10)).onTapGesture {
            if self.day.disabled == false && self.day.selectableDays {
                self.day.isSelected.toggle()
            }
        }
    }
    
    func moodText() -> some View {
        var moodColor: Color = .clear // Default color if no mood is found
        
        for m in moodModelController.moods {
            if m.monthString == day.monthString && m.dayAsInt == day.dayAsInt && m.year == day.year {
                moodColor = {
                    switch m.emotion.state {
                    case .happy:
                        return .yellow
                    case .relaxed:
                        return .purple
                    case .anxious:
                        return .green
                    case .sad:
                        return .blue
                    case .angry:
                        return .red
                    }
                }()
                break // Exit the loop once we find a matching mood
            }
        }
        
        return Capsule()
            .fill(moodColor)
            .frame(width: 20, height: 10)
            .opacity(moodColor == .clear ? 0 : 1) // Hide the circle if no mood was found
    }
}
#Preview {
    DayCellView(moodModelController: MoodModelController(), day: Day(date: Date()))
}
