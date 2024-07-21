//
//  Calendar.swift
//  Moodly
//
//  Created by Marian Nasturica on 20.07.2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    
    var moodLog: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date().addingTimeInterval(-86400)): ["Anxious", "Happy", "Sad"],
        Calendar.current.startOfDay(for: Date().addingTimeInterval(-172800)): ["Happy", "Relaxed", "Anxious"]
    ]
    
    let moodz: [DailyMoods] = [.list]
    
    var moods: [String: Color] = [
        "Happy": .yellow,
        "Anxious": .green,
        "Sad": .blue,
        "Anger": .red,
        "Relaxed": .purple
    ]
    
    var todayHighlightColor: Color = .gray // Color for highlighting today's date
    
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
        ZStack{
            Color.background.ignoresSafeArea()
            VStack {
                CalendarHelper(
                    calendar: calendar,
                    date: $selectedDate,
                    content: { date in
                        Button(action: { selectedDate = date }) {
                            Text(dayFormatter.string(from: date))
                                .frame(width: 25, height: 25)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(
                                    backgroundColor(for: date)
                                )
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
                Spacer()
                List(moodz, children: \.items) { row in
                    HStack{
                        Circle()
                            .fill(row.color)
                            .frame(width: 20)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                        Text(row.name)
                    }
                }.tint(.black)
                    .scrollContentBackground(.hidden)
            }
            .padding()
        }
    }

func backgroundColor(for date: Date) -> some View {
    let dayStart = Calendar.current.startOfDay(for: date)
    
    if Calendar.current.isDateInToday(date) {
        return AnyView(todayHighlightColor) // Highlight today's date
    } else if let moodsForDay = moodLog[dayStart] {
        return AnyView(linearGradientColor(for: moodsForDay)) // Gradient from multiple moods
    } else if date > Date() {
        return AnyView(Color.gray.opacity(0.3)) // Future dates
    } else {
        return AnyView(Color.gray.opacity(1)) // Past day with no mood
    }
}

func borderColor(for date: Date) -> Color {
    if Calendar.current.isDateInToday(date) {
        return .gray // Blue stroke for today's date
    } else {
        return .clear // No stroke for other dates
    }
}

func linearGradientColor(for moodsForDay: [String]) -> LinearGradient {
    let colors = moodsForDay.compactMap { moods[$0] }
    let gradient = Gradient(colors: colors)
    return LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
}
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView(
            calendar: Calendar.current)
    }
}

