//
//  HomeView.swift
//  Moodly
//
//  Created by Marian Nasturica on 12.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var moodModelController: MoodModelController
    @ObservedObject var day: Day
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ZStack {
                VStack{ //Used for pushing the Gradient Rounded Rectangle to the top
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .frame(width: UIScreen.current!.bounds.width, height: (UIScreen.current?.bounds.height)! / 3.2)
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [.brandPrimary, .brandPink]), startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.9))
                            )
                            .shadow(color: .black.opacity(0.2), radius: 10)
                            HStack{
                                Text("Hi Stranger 👋")
                                    .padding(.horizontal, 20)
                                    .font(SetFont.setFontStyle(.medium, 32))
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
                        
                        HStack { // Mood Quick Actions
                            Button(action: {
                                print("Angry pressed")
                            }) {
                                Text("😡")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Sad pressed")
                            }) {
                                Text("😢")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Anxious pressed")
                            }) {
                                Text("😬")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Calm pressed")
                            }) {
                                Text("😌")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Happy pressed")
                            }) {
                                Text("😃")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
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
                                                .fill(Color.pink.opacity(0.4))
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




//extension HomeView {
//    func moodText() -> some View {
//        var moodColor: Color = .brandGray // Default color if no mood is found
//        
//        for m in moodModelController.moods {
//            if m.monthString == day.monthString && m.dayAsInt == day.dayAsInt && m.year == day.year {
//                moodColor = {
//                    switch m.emotion.state {
//                    case .happy:
//                        return .yellow
//                    case .relaxed:
//                        return .purple
//                    case .anxious:
//                        return .green
//                    case .sad:
//                        return .blue
//                    case .angry:
//                        return .red
//                    }
//                }()
//                break // Exit the loop once we find a matching mood
//            }
//        }
//        
//        return HStack(spacing: 10) { // Days at a glance
//            ForEach(getLast7Days()) { day in
//                VStack(spacing: 5) {
//                    Text(day.dayName)
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                    ZStack{
//                        Capsule()
//                            .fill(day.isPast ? moodColor : day.isFuture ? .gray : moodColor)
//                            .frame(width: 35, height: 85)
//                            .opacity(moodColor == .clear ? 0 : 0.8)// Hide the circle if no mood was found
//                            .overlay(
//                                VStack {
//                                    Spacer()
//                                    ZStack {
//                                        if day.isToday {
//                                            Circle()
//                                                .fill(Color.pink.opacity(0.8))
//                                                .frame(width: 34, height: 34)
//                                        }
//                                        Text(day.date)
//                                            .font(.body)
//                                            .foregroundColor(.black)
//                                            .padding(.vertical, 7)
//                                    }
//                                }
//                            )
//                    }
//                }
//            }
//        }
//    }
//}
