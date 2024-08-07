//
//  CalendarsV.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI


struct CalendarHelper: View {
    @ObservedObject var moodModelController: MoodModelController
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = true
    @State var selectedDay: Date?
    
    init(moodModelController: MoodModelController, startDate: Date, monthsToDisplay: Int, selectableDays: Bool = true, selectedDay: Date? = nil) {
        self.moodModelController = moodModelController
        self.startDate = startDate
        self.monthsToDisplay = monthsToDisplay
        self.selectableDays = selectableDays
        self.selectedDay = selectedDay
    }
    
    public var body: some View {
        
        VStack {
            MonthView(moodModelController: moodModelController)
            Spacer()
        }
    }
    
    
}

#Preview {
    CalendarHelper(moodModelController: MoodModelController(), startDate: Date(), monthsToDisplay: 2)
}
