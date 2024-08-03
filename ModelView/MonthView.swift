//
//  MonthView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var moodModelController: MoodModelController
    @State private var month = Month(startDate: Date(), selectableDays: false)
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    month = month.previousMonth()
                } label: {
                    Image(systemName: "chevron.left")
                    }.frame(width: 35, height: 35)
                    .background(Color.brandGreen)
                    .tint(Color.brandBlack)
                    .clipShape(Circle())
                Spacer()
                Text("\(month.monthNameYear)")
                    .font(SetFont.setFontStyle(.bold, 22))
                    .padding(.vertical, 8)
                Spacer()
                Button {
                   month = month.nextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                    }.frame(width: 35, height: 35)
                    .background(Color.brandGreen)
                    .tint(Color.brandBlack)
                    .clipShape(Circle())
            }.padding()
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
    MonthView(moodModelController: MoodModelController())
}
