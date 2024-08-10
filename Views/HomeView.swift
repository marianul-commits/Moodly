//
//  HomeView.swift
//  Moodly
//
//  Created by Marian Nasturica on 12.07.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    
    @ObservedObject var moodModelController = MoodModelController()
    @State private var emotionState: EmotionState = .happy
    @State private var moodColor: MoodColor = .happyColor
    @ObservedObject var day: Day
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("username") private var username: String = ""
    @State private var selectedDate = Date()
    @State var text: String? = nil
    
    var body: some View {
        VStack {
            ZStack {
                VStack{ //Used for pushing the Gradient Rounded Rectangle to the top
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .frame(width: UIScreen.current!.bounds.width, height: (UIScreen.current?.bounds.height)! / 3.2)
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [.brandPrimary, .brandPink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 10)
                        HStack{
                            Text(greetUser(user: username))
                                .padding(.horizontal, 20)
                                .font(SetFont.setFontStyle(.medium, 24))
                            Spacer()
                        }
                    }
                    Spacer()
                }
                VStack { // Used for nesting the White Rounded Rectangles
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(colorScheme == .dark ? .brandGray : .brandWhite )
                            .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                        
                        HStack(alignment: .center, spacing: 2) { // Mood Quick Actions
                            Button(action: {
                                self.emotionState = .angry
                                self.moodColor = .angryColor
                                self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: getCurrentTimeOfDay())
                            }) {
                                VStack{
                                    Image(.angryFace)
                                        .resizable()
                                        .frame(width: 70, height: 90)
                                        .padding(.horizontal, -4)
                                    Text("Angry")
                                        .offset(y: -23)
                                        .foregroundStyle(.brandText)
                                        .font(SetFont.setFontStyle(.regular, 14))
                                }
                            }
                            
                            Button(action: {
                                self.emotionState = .sad
                                self.moodColor = .sadColor
                                self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: getCurrentTimeOfDay())
                            }) {
                                VStack{
                                    Image(.sadFace)
                                        .resizable()
                                        .frame(width: 60, height: 80)
                                        .padding(.horizontal, 4)
                                    Text("Sad")
                                        .offset(y: -18)
                                        .foregroundStyle(.brandText)
                                        .font(SetFont.setFontStyle(.regular, 14))
                                }
                            }
                            
                            Button(action: {
                                self.emotionState = .anxious
                                self.moodColor = .anxiousColor
                                self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: getCurrentTimeOfDay())
                            }) {
                                VStack{
                                    Image(.anxiousFace)
                                        .resizable()
                                        .frame(width: 60, height: 80)
                                        .padding(.horizontal, 4)
                                    Text("Anxious")
                                        .offset(y: -18)
                                        .foregroundStyle(.brandText)
                                        .font(SetFont.setFontStyle(.regular, 14))
                                }
                            }
                            
                            Button(action: {
                                self.emotionState = .relaxed
                                self.moodColor = .relaxedColor
                                self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: getCurrentTimeOfDay())
                            }) {
                                VStack{
                                    Image(.relaxedFace)
                                        .resizable()
                                        .frame(width: 60, height: 80)
                                        .padding(.horizontal, 4)
                                    Text("Relaxed")
                                        .offset(y: -18)
                                        .foregroundStyle(.brandText)
                                        .font(SetFont.setFontStyle(.regular, 14))
                                }
                            }
                            
                            Button(action: {
                                self.emotionState = .happy
                                self.moodColor = .happyColor
                                self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: getCurrentTimeOfDay())
                            }) {
                                VStack{
                                    Image(.happyFace)
                                        .resizable()
                                        .frame(width: 60, height: 80)
                                        .padding(.horizontal, 4)
                                    Text("Happy")
                                        .offset(y: -18)
                                        .foregroundStyle(.brandText)
                                        .font(SetFont.setFontStyle(.regular, 14))
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(colorScheme == .dark ? .brandGray.opacity(0.7) : .brandWhite )
                            .frame(width: UIScreen.main.bounds.width - 50, height: 170)
                            .padding(.vertical, 10)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                        moodText()
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(colorScheme == .dark ? .brandGray.opacity(0.7) : .brandWhite )
                            .frame(width: UIScreen.main.bounds.width - 50, height: 170)
                            .padding(.vertical, 10)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                            .overlay(

                                Chart {
                                    ForEach(EmotionState.allCases, id: \.self) { state in
                                        BarMark(
                                            x: .value("Type", state.rawValue.capitalized),
                                            y: .value("Count", moodModelController.moods.filter { $0.emotion.state == state }.count)
                                        )
                                        .cornerRadius(10)
                                        .foregroundStyle(Emotion(state: state, color: MoodColor(rawValue: state.rawValue + "Color")!).moodColor)
                                    }
                                }
                                    .frame(width: (UIScreen.current?.bounds.width)! - 80, height: 150)
                                    .aspectRatio(contentMode: .fill)
                                    .padding()
                            )
                    }
                }
                .zIndex(1)
            }
        }
        .background(Color.background)
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView(moodModelController: MoodModelController(), day: Day(date: Date()))
}

extension HomeView {
    
    func getCurrentTimeOfDay() -> TimeOfDay {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return .morning
        case 12..<17:
            return .noon
        default:
            return .evening
        }
    }
    
    func getLast7Days() -> [Day] {
        let calendar = Calendar.current
        var days = [Day]()
        
        for i in -3...3 {
            if let date = calendar.date(byAdding: .day, value: i, to: Date()) {
                let isToday = calendar.isDateInToday(date)
                let isPast = i < 0
                let isFuture = i > 0
                let day = Day(date: date, today: isToday, disable: !isPast && !isFuture, selectable: true)
                days.append(day)
            }
        }
        
        return days
    }
    
    func greetUser(user: String) -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        var greeting = ""
        var emoji = ""
        
        switch hour {
        case 7..<12:
            greeting = "Morning"
            emoji = "☀️"
        case 12..<19:
            greeting = "Good afternoon"
            emoji = "🌤️"
        default:
            greeting = "Good evening"
            emoji = "🥱"
        }
        
        var result = "\(greeting), \(user)! \(emoji)"
        
        return result
    }
    
    func moodText() -> some View {
        HStack(spacing: 10) { // Days at a glance
            ForEach(getLast7Days(), id: \.dayDate) { day in
                let moodGradient = getMoodGradient(for: day)
                VStack(spacing: 5) {
                    Text(day.dayName)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    ZStack {
                        Capsule()
                            .fill(moodGradient)
                            .frame(width: 35, height: 85)
                            .overlay(
                                VStack {
                                    Spacer()
                                    ZStack {
                                        if day.isToday {
                                            Circle()
                                                .fill(Color.brandPink.opacity(0.7))
                                                .frame(width: 34, height: 34)
                                        }
                                        Text(day.dayName)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.vertical, 7)
                                    }
                                }
                            )
                    }
                }
            }
        }
    }
    
    
    func getMoodGradient(for day: Day) -> LinearGradient {
        let colors = Colors()
        var moodColors: [Color] = []
        
        for m in moodModelController.moods {
            if m.monthString == day.monthString && m.dayAsInt == day.dayAsInt && m.year == day.year {
                if let color = colors.moodColors[m.emotion.state.rawValue] {
                    moodColors.append(color)
                }
            }
        }
        
        if moodColors.isEmpty {
            moodColors = [colors.disabledColor] // Use default color if no moods found
        }
        
        return LinearGradient(gradient: Gradient(colors: moodColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    
}
