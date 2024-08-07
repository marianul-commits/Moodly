//
//  WeekdayView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct WeekdayView: View {
    let weekdays = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"]
    let colors = Colors()
    
    var body: some View {
        HStack {
            GridStackView(rows: 1, columns: 7) { row, col in
                Text(self.weekdays[col])
                    .font(SetFont.setFontStyle(.regular, 16))
            }
        }.padding(.bottom, 20).background(colors.weekdayBackgroundColor)
    }
}

#Preview {
    WeekdayView()
}
