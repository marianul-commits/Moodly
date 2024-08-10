//
//  MoodRemoveView.swift
//  Moodly
//
//  Created by Marian Nasturica on 06.08.2024.
//

import SwiftUI

struct MoodRemoveView: View {
    @ObservedObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String? = nil
    @State private var selectedDate = Date()
    @State private var selectedOption: TimeOfDay = .morning
    @State private var selectedTimeOfDay: TimeOfDay? = nil
    @State private var showAlert = false
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack(spacing: 30) {
                let options = getAvailableOptions()
                
                
                Text("What do we remove \(formattedDateString(for: selectedDate))?")
                    .safeAreaPadding(.top, 15)
                    .font(SetFont.setFontStyle(.bold, 20))
                DatePicker("Select Date", selection: $selectedDate,in:...Date(), displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .font(SetFont.setFontStyle(.bold, 20))
                
                if options.count == 1 {
                    Text("Remove \(selectedOption) mood")
                        .font(SetFont.setFontStyle(.medium, 18))
                        .padding()
                } else {
                    HStack(alignment: .firstTextBaseline, spacing: 2){
                        Text("Remove")
                            .font(SetFont.setFontStyle(.medium, 18))
                        Picker("", selection: $selectedOption) {
                            ForEach(options, id: \.self) { option in
                                Text("\(option)")
                                    .font(SetFont.setFontStyle(.medium, 18))
                            }
                        }
                        .tint(.brandText)
                        .pickerStyle(.menu)
                        .padding(.vertical, 8)
                        Text("mood")
                            .font(SetFont.setFontStyle(.medium, 18))
                    }
                }
                
                Button(action: {
                    deleteLastMood(for: selectedOption)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Remove Mood")
                        .font(SetFont.setFontStyle(.bold, 18))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        .background(Color.brandPrimary)
                        .foregroundColor(.brandText)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Clear Day")
                        .font(SetFont.setFontStyle(.bold, 18))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        .background(Color.brandDanger.opacity(0.7))
                        .foregroundColor(.brandText)
                        .cornerRadius(10)
                }.alert("Are you sure you want to clear the day?", isPresented: $showAlert) {
                    Button("Yes") {
                        clearSelectedDay()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("No", role: .cancel) {}
                }
                
                Spacer()
            }.padding()
        }
    }
    
    private func deleteLastMood(for timeOfDay: TimeOfDay) {
        let calendar = Calendar.current
        let moodsForSelectedDateAndTime = moodModelController.moods.filter {
            calendar.isDate($0.date, inSameDayAs: selectedDate) && $0.timeOfDay == timeOfDay
        }
        if let lastMood = moodsForSelectedDateAndTime.last {
            if let index = moodModelController.moods.firstIndex(of: lastMood) {
                moodModelController.deleteMood(at: IndexSet(integer: index))
            }
        }
    }
    
    private func clearSelectedDay() {
        for timeOfDay in TimeOfDay.allCases {
            moodModelController.clearMood(date: selectedDate, timeOfDay: timeOfDay)
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
            return "from \(formattedDate)"
        }
    }
    
    func getAvailableOptions() -> [TimeOfDay] {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return [.morning]
        case 12..<17:
            return [.morning, .noon]
        default:
            return [.morning, .noon, .evening]
        }
    }
    
}

#Preview {
    MoodRemoveView(moodModelController: MoodModelController())
}
