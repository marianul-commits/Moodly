//
//  SwiftUIView.swift
//  Moodly
//
//  Created by Marian Nasturica on 10.07.2024.
//

import SwiftUI

//    .scrollContentBackground(.hidden)

struct ContentView2: View {
    @State private var selectedDate = Date()
    @State private var showSheet = false
    @State private var moodLog: [Date: [String]] = [:]
    
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    
    let moodz: [DailyMoods] = [.list]
    
    init(calendar: Calendar) {
        var calendar = calendar
        calendar.firstWeekday = 2 // Start week on Monday
        self.calendar = calendar
        self.monthFormatter = DateFormatter()
        self.monthFormatter.dateFormat = "MMMM"
        self.dayFormatter = DateFormatter()
        self.dayFormatter.dateFormat = "d"
        self.weekDayFormatter = DateFormatter()
        self.weekDayFormatter.dateFormat = "EEEEE"
    }

    var body: some View {
        VStack {
            CalendarHelper(
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    Button(action: {
                        selectedDate = date
                        showSheet.toggle()
                    }) {
                        Text(dayFormatter.string(from: date))
                            .frame(width: 25, height: 25)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(backgroundColor(for: date))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(borderColor(for: date), lineWidth: 4)
                            )
                            .cornerRadius(8)
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date))
                },
                title: { date in
                    HStack {
                        Text(monthFormatter.string(from: date))
                            .font(.headline)
                            .padding()
                        Spacer()
                        Button {
                            withAnimation {
                                guard let newDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) else { return }
                                selectedDate = newDate
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .padding(.horizontal)
                        }
                        Button {
                            withAnimation {
                                guard let newDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) else { return }
                                selectedDate = newDate
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 6)
                }
            )
            .fullScreenCover(isPresented: $showSheet) {
                MoodSheetView(date: selectedDate, moodLog: $moodLog)
            }
                List(moodz, children: \.items) { row in
                    HStack {
                        Circle()
                            .fill(row.color)
                            .frame(width: 20)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                        Text(row.name)
                    }
                }
                .tint(.black)
                .scrollContentBackground(.hidden)
                .transition(.slide)
            Spacer()
        }
        .padding()
    }

    func backgroundColor(for date: Date) -> some View {
        let dayStart = Calendar.current.startOfDay(for: date)
        
        if let moodsForDay = moodLog[dayStart] {
            return AnyView(linearGradientColor(for: moodsForDay))
        } else if date > Date() {
            return AnyView(Color.gray.opacity(0.3)) // Future dates
        } else {
            return AnyView(Color.gray.opacity(1)) // Past day with no mood
        }
    }
    
    func borderColor(for date: Date) -> Color {
        if Calendar.current.isDateInToday(date) {
            return .blue // Blue stroke for today's date
        } else {
            return .clear // No stroke for other dates
        }
    }
    
    func linearGradientColor(for moodsForDay: [String]) -> LinearGradient {
        let colors = moodsForDay.compactMap { mood in
            moodz.flatMap { $0.items ?? [] }.first(where: { $0.name == mood })?.color
        }
        let gradient = Gradient(colors: colors)
        return LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct CalendarPreview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2(
            calendar: Calendar.current
        )
    }
}
