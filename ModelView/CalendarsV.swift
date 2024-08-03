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
            MonthView(moodModelController: moodModelController)
            Spacer()
        }
    }
    
    
}

#Preview {
    CalendarsV(start: Date(), monthsToShow: 2, moodController: MoodModelController())
}
