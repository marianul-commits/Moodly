//
//  MoodSheetView.swift
//  Moodly
//
//  Created by Marian Nasturica on 21.07.2024.
//

import SwiftUI

struct AddMoodView: View {
    @Environment(\.dismiss) var dismiss
        
    @State private var morningMood: String = ""
    @State private var noonMood: String = ""
    @State private var eveningMood: String = ""
    
    let moodOptions = ["Happy", "Relaxed", "Anxious", "Sad", "Anger"]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Select Moods for \(Date.now, formatter: DateFormatter())")
                .font(SetFont.setFontStyle(.medium, 20))
                .padding()
            Spacer()
            MoodPicker(title: "Morning", selection: $morningMood, options: moodOptions)
            Spacer()
            MoodPicker(title: "Noon", selection: $noonMood, options: moodOptions)
            Spacer()
            MoodPicker(title: "Evening", selection: $eveningMood, options: moodOptions)
            Spacer()
            
            Button("Save") {
                dismiss()
                }
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct MoodPicker: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(SetFont.setFontStyle(.medium, 18))
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .font(SetFont.setFontStyle(.thinItalic, 14))
                        .tag(option)
                }
            }
            .pickerStyle(.menu)
            .padding(.vertical)
        }
    }
}

struct MoodSheetView_Previews: PreviewProvider {
    static var previews: some View {
        // Creating a mock mood log and a date for the preview
        AddMoodView()
    }
}
