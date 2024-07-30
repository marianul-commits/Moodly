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
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Add a Mood Entry")
                    .font(SetFont.setFontStyle(.bold, 24))
                DatePicker("Select Date", selection: $selectedDate,in:...Date(), displayedComponents: .date)
                    .datePickerStyle(.compact)
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
                        Circle()
                            .fill(.yellow)
                            .stroke(happyIsSelected ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: 35)
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
                        Circle()
                            .fill(.purple)
                            .stroke(relaxedIsSelected ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: 35)
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
                        Circle()
                            .fill(.green)
                            .stroke(anxiousIsSelected ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: 35)
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
                        Circle()
                            .fill(.blue)
                            .stroke(sadIsSelected ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: 35)
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
                        Circle()
                            .fill(.red)
                            .stroke(angryIsSelected ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: 35)
                    }
                }
                Button(action: {
                    self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: selectedDate)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Mood Entry").bold().frame(width: UIScreen.main.bounds.width - 30, height: 50).background(Color.blue).foregroundColor(.white).cornerRadius(10)
                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    MoodView(moodModelController: MoodModelController())
}
