//
//  MoodSheetView.swift
//  Moodly
//
//  Created by Marian Nasturica on 21.07.2024.
//

import SwiftUI


struct TimePickerView: View {
    @State private var selectedOption: String = "Morning"

    var body: some View {
        let options = getAvailableOptions()
        
        VStack {
            if options.count == 1 {
                Text(selectedOption)
                    .font(SetFont.setFontStyle(.medium, 18))
                    .padding()
            } else {
                Picker("Select Time", selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .font(SetFont.setFontStyle(.medium, 18))
                    }
                }
                .pickerStyle(.menu)
                .padding()
            }
        }
    }

    func getAvailableOptions() -> [String] {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return ["Morning"]
        case 12..<17:
            return ["Morning", "Afternoon"]
        default:
            return ["Morning", "Afternoon", "Evening"]
        }
    }
}

//import SwiftData
//
//struct AddMoodView: View {
//    @Environment(\.modelContext) var modelContext
//    @Bindable var moods: MoodItem
//    @Environment(\.dismiss) var dismiss
//    @State var moodDate: Date
//    @State var moodColors: [Color] = []
//    
//    let moodOptions = ["Happy", "Relaxed", "Anxious", "Sad", "Angry"]
//    
//    let moodColorMap: [String: String] = [
//        "Happy": "yellow",
//        "Relaxed": "purple",
//        "Anxious": "green",
//        "Sad": "blue",
//        "Angry": "red"
//    ]
//    
//    var body: some View {
//        
//        Form{
//            Section{
//                Text("Select Mood for \(moodDate.formatted(date: .abbreviated, time: .omitted))")
//            }
//            
//            Section("How did you feel this morning"){
//                Picker("", selection: $moods.morningMood) {
//                    Text("Select the mood").tag(nil as MoodItem?)
//                        ForEach(moodOptions, id: \.self) { morning in
//                            Text(morning).tag(morning)
//                        }
//                    }.labelsHidden()
//                Text("\(moods.morningMood)")
//                Text("\(moodColorMap[moods.morningMood] ?? "")")
//            }
//            
//            Section("How did you feel this afternoon"){
//                Picker("", selection: $moods.afternoonMood) {
//                    Text("Select the mood").tag(nil as MoodItem?)
//                    ForEach(moodOptions, id: \.self) { noon in
//                        Text(noon).tag(noon)
//                    }
//                }.labelsHidden()
//                Text("\(moods.afternoonMood)")
//                Text("\(moodColorMap[moods.afternoonMood] ?? "")")
//            }
//            
//            Section("How did you feel this evening"){
//                Picker("", selection: $moods.eveningMood) {
//                    Text("Select the mood").tag(nil as MoodItem?)
//                    ForEach(moodOptions, id: \.self) { evening in
//                        Text(evening).tag(evening)
//                    }
//                }.labelsHidden()
//                Text("\(moods.eveningMood)")
//                Text("\(moodColorMap[moods.eveningMood] ?? "")")
//            }
//            
//            Button(action: {
////                print("morning: ", moodData.morning, "evening: ", moodData.evening, "noon: ", moodData.noon)
////                print(modelContext.sqliteCommand)
//                modelContext.insert(MoodItem(date: moodDate, morningMood: moods.morningMood, afternoonMood: moods.afternoonMood, eveningMood: moods.eveningMood, morningColor: moodColorMap[moods.morningMood] ?? "gray" , afternoonColor: moodColorMap[moods.afternoonMood] ?? "gray", eveningColor: moodColorMap[moods.eveningMood] ?? "gray"))
//                dismiss()
//            }) {
//                HStack(alignment: .center) {
//                    Spacer()
//                    Text("Save")
//                    Image(systemName: "square.and.arrow.down")
//                    Spacer()
//                }
//            }
//            
//        }
//    }
//    
//    func saveMood(_ mood: String?) {
//        guard let mood = mood else { return }
//    }
//    
//}
//    
//extension ModelContext {
//    var sqliteCommand: String {
//        if let url = container.configurations.first?.url.path(percentEncoded: false) {
//            "sqlite3 \"\(url)\""
//        } else {
//            "No SQLite database found."
//        }
//    }
//}
//
//
//struct PickerSection: View {
//    let title: String
//    @Binding var selection: String
//    let moodOptions = ["Happy", "Relaxed", "Anxious", "Sad", "Angry"]
//
//    var body: some View {
//        Section(title) {
//            Picker("", selection: $selection) {
//                ForEach(moodOptions, id: \.self) {
//                    Text($0)
//                }
//            }
//            .labelsHidden()
//        }
//    }
//}
//
////struct MoodSheetView_Previews: PreviewProvider {
////    static var previews: some View {
////        // Creating a mock mood log and a date for the preview
////        AddMoodView(moodDate: Date())
////    }
////}
