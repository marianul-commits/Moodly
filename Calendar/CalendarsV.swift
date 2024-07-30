//
//  CalendarsV.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct CalendarsV: View {
    @ObservedObject var moodModelController: MoodModelController
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = false
    

    init(start: Date, monthsToShow: Int, daysSelectable: Bool = false, moodController: MoodModelController) {
    self.startDate = start
    self.monthsToDisplay = monthsToShow
    self.selectableDays = daysSelectable
    self.moodModelController = moodController
    }

    public var body: some View {
        
        VStack {
            ScrollView {
                MonthView(moodModelController: moodModelController, month: Month(startDate: startDate, selectableDays: selectableDays))
                if monthsToDisplay > 1 {
                    ForEach(1..<self.monthsToDisplay) {
                        MonthView(moodModelController: self.moodModelController, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: $0), selectableDays: self.selectableDays))
                    }
                }
            }
            Spacer()
        }
    }

    func nextMonth(currentMonth: Date, add: Int) -> Date {
        var components = DateComponents()
        components.month = add
        let next = Calendar.current.date(byAdding: components, to: currentMonth)!
        return next
    }


}

#Preview {
    CalendarsV(start: Date(), monthsToShow: 2, moodController: MoodModelController())
}
