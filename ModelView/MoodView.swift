//
//  MoodView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct MoodView: View {
    @ObservedObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String? = nil
    @State private var emotionState: EmotionState = .happy
    @State private var moodColor: MoodColor = .happyColor
    @State private var happyIsSelected = false
    @State private var relaxedIsSelected = false
    @State private var anxiousIsSelected = false
    @State private var sadIsSelected = false
    @State private var angryIsSelected = false
    @State private var selectedDate = Date()
    @State private var selectedOption: TimeOfDay = .morning
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack(spacing: 30) {
                let options = getAvailableOptions()
                
                
                Text("How did you feel \(formattedDateString(for: selectedDate))?")
                    .safeAreaPadding(.top, 15)
                    .font(SetFont.setFontStyle(.bold, 24))
                DatePicker("Select Date", selection: $selectedDate,in:...Date(), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .font(SetFont.setFontStyle(.bold, 20))
                
                if options.count == 1 {
                    Text("How did you feel this \(selectedOption)")
                        .font(SetFont.setFontStyle(.medium, 18))
                        .padding()
                } else {
                    HStack(alignment: .firstTextBaseline, spacing: 2){
                    Text("How did you feel this")
                            .font(SetFont.setFontStyle(.medium, 18))
                    Picker("", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text("\(option)?")
                                .font(SetFont.setFontStyle(.medium, 18))
                        }
                    }
                    .tint(.brandText)
                    .pickerStyle(.menu)
                    .padding(.vertical, 8)
                }
            }
                
                HStack(spacing: 15) {
                    Button(action: {
                        self.emotionState = .happy
                        self.moodColor = .happyColor
                        self.happyIsSelected = true
                        self.relaxedIsSelected = false
                        self.anxiousIsSelected = false
                        self.sadIsSelected = false
                        self.angryIsSelected = false
                    }) {
                        VStack{
                            Circle()
                                .fill(.yellow)
                                .stroke(happyIsSelected ? Color.white : Color.clear, lineWidth: 3)
                                .frame(width: 35)
                            Text("Happy")
                                .font(SetFont.setFontStyle(.medium, 16))
                                .foregroundStyle(.brandText)
                        }
                    }
                    Button(action: {
                        self.emotionState = .relaxed
                        self.moodColor = .relaxedColor
                        self.happyIsSelected = false
                        self.relaxedIsSelected = true
                        self.anxiousIsSelected = false
                        self.sadIsSelected = false
                        self.angryIsSelected = false
                    }) {
                        VStack{
                            Circle()
                                .fill(.purple)
                                .stroke(relaxedIsSelected ? Color.white : Color.clear, lineWidth: 3)
                                .frame(width: 35)
                            Text("Relaxed")
                                .font(SetFont.setFontStyle(.medium, 16))
                                .foregroundStyle(.brandText)
                        }
                    }
                    Button(action: {
                        self.emotionState = .anxious
                        self.moodColor = .anxiousColor
                        self.happyIsSelected = false
                        self.relaxedIsSelected = false
                        self.anxiousIsSelected = true
                        self.sadIsSelected = false
                        self.angryIsSelected = false
                    }) {
                        VStack{
                            Circle()
                                .fill(.green)
                                .stroke(anxiousIsSelected ? Color.white : Color.clear, lineWidth: 3)
                                .frame(width: 35)
                            Text("Anxious")
                                .font(SetFont.setFontStyle(.medium, 16))
                                .foregroundStyle(.brandText)
                        }
                    }
                    Button(action: {
                        self.emotionState = .sad
                        self.moodColor = .sadColor
                        self.happyIsSelected = false
                        self.relaxedIsSelected = false
                        self.anxiousIsSelected = false
                        self.sadIsSelected = true
                        self.angryIsSelected = false
                    }) {
                        VStack{
                            Circle()
                                .fill(.blue)
                                .stroke(sadIsSelected ? Color.white : Color.clear, lineWidth: 3)
                                .frame(width: 35)
                            Text("Sad")
                                .font(SetFont.setFontStyle(.medium, 16))
                                .foregroundStyle(.brandText)
                        }
                    }
                    Button(action: {
                        self.emotionState = .angry
                        self.moodColor = .angryColor
                        self.happyIsSelected = false
                        self.relaxedIsSelected = false
                        self.anxiousIsSelected = false
                        self.sadIsSelected = false
                        self.angryIsSelected = true
                    }) {
                        VStack{
                            Circle()
                                .fill(.red)
                                .stroke(angryIsSelected ? Color.white : Color.clear, lineWidth: 3)
                                .frame(width: 35)
                            Text("Angry")
                                .font(SetFont.setFontStyle(.medium, 16))
                                .foregroundStyle(.brandText)
                        }
                    }
                }
                Button(action: {
                    self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate, timeOfDay: selectedOption)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Mood Entry")
                        .font(SetFont.setFontStyle(.bold, 18))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50).background(Color.brandPrimary).foregroundColor(.brandText).cornerRadius(10)
                }
                Spacer()
            }.padding()
        }
    }
    
    func formattedDateString(for selectedDate: Date) -> String {
        let today = Date()
        let calendar = Calendar.current

        if calendar.isDate(selectedDate, inSameDayAs: today) {
            return "today"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            let formattedDate = dateFormatter.string(from: selectedDate)
            return "on \(formattedDate)"
        }
    }
    
    func getAvailableOptions() -> [TimeOfDay] {
        
        let today = Date()
        let calendar = Calendar.current
        
        if !calendar.isDate(selectedDate, inSameDayAs: today) {
            return [.morning, .noon, .evening]
        }
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 7..<12:
            return [.morning]
        case 12..<19:
            return [.morning, .noon]
        default:
            return [.morning, .noon, .evening]
        }
    }
    
}

#Preview {
    MoodView(moodModelController: MoodModelController())
}
