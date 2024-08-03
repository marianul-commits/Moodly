//
//  EntriesViewModel.swift
//  Moodly
//
//  Created by Marian Nasturica on 02.08.2024.
//

import SwiftUI

struct EntriesViewModel: View {
    
    @State var titles = ""
    @State var bodys = ""
    @State var moodzs = ""
    @State var emotionsz: [String] = []
    @State var dates = Date()
    @ObservedObject var moodModelController: MoodModelController
    @ObservedObject var day: Day
    
    let dateFormatters = DateFormatter()
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.background)
                .frame(width: (UIScreen.current?.bounds.width)! - 20, height: 150)
                .overlay(
            HStack{
                Rectangle()
                    .fill(moodColor())
                    .frame(width: 35, height: 150)
                    .roundedCorner(20, corners: [.topLeft, .bottomLeft])
                VStack(alignment: .leading){
                    Spacer()
                    Text("Feeling \(moodzs)")
                        .font(SetFont.setFontStyle(.medium, 16))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .foregroundStyle(.brandText)
                    Text("\(titles)")
                        .font(SetFont.setFontStyle(.semibold, 18))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 5)
                        .foregroundStyle(.brandText)
                    Text("\(bodys)")
                        .font(SetFont.setFontStyle(.regular, 14))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .foregroundStyle(.brandText)
                    HStack{
                        Text("\(emotionsz)")
                            .font(SetFont.setFontStyle(.regular, 12))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 5)
                            .foregroundStyle(.brandText)
                        Spacer()
                        Text(dates.formatted(date: .abbreviated, time: .omitted))
                            .font(SetFont.setFontStyle(.regular, 12))
                            .padding(.horizontal, 15)
                            .foregroundStyle(.brandText)
                    }
                    Spacer()
                }
                Spacer()
            })
        }
    }
    
    func moodColor() -> LinearGradient {
        return getMoodGradient(for: day, moodModelController: moodModelController)
    }

    func getMoodGradient(for day: Day, moodModelController: MoodModelController) -> LinearGradient {
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
            moodColors = [Color.clear] // Use default color if no moods found
        }

        return LinearGradient(gradient: Gradient(colors: moodColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
}

#Preview {
    EntriesViewModel(moodModelController: MoodModelController(), day: Day(date: Date()))
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
