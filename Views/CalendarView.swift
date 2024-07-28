//
//  Calendar.swift
//  Moodly
//
//  Created by Marian Nasturica on 20.07.2024.
//

import SwiftUI

struct CalendarView: View {

    @ObservedObject var moodModelController = MoodModelController()
    
    var body: some View {
        Calendar(start: Date(), monthsToShow: 1, daysSelectable: true, moodController: moodModelController)
    }
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

