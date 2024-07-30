//
//  MonthView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var moodModelController: MoodModelController
        var month: Month

        var body: some View {
            VStack {
                Text("\(month.monthNameYear)")
                    .font(SetFont.setFontStyle(.bold, 22))
                WeekdayView()
                GridStackView(rows: month.monthRows, columns: month.monthDays.count) { row, col in
                    if self.month.monthDays[col+1]![row].dayDate == Date(timeIntervalSince1970: 0) {
                        Text("").frame(width: 32, height: 32)
                    } else {
                        DayCellView(moodModelController: self.moodModelController, day: self.month.monthDays[col+1]![row])
                    }

                }
            }
            .padding(.bottom, 20)

        }
    }

#Preview {
    MonthView(moodModelController: MoodModelController(), month: Month(startDate: Date(), selectableDays: true))
}
