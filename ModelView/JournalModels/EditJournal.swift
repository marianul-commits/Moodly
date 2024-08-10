//
//  EditJournal.swift
//  Moodly
//
//  Created by Marian Nasturica on 16.07.2024.
//

import SwiftUI
import SwiftData

struct EditJournal: View {
    
    @Bindable var entries: JournalItem
    @ObservedObject var emotions = EmotionsViewModel()
    @State private var noteTitle: String = ""
    @State private var isShowingEmotion = false
    @State private var isShowingMood = false
    @State private var noteBody: String = ""
    @State private var selectedMood: String? = nil
    @State private var selectedEmotions: [String]? = nil
    @State private var placeholderText: String = "How are you feeling?"
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button(action: {
                    isShowingMood = true
                    selectedMood = entries.mood
                }) {
                    Text("\(changeMoodText())")
                        .foregroundStyle(.brandText)
                        .font(SetFont.setFontStyle(.medium, 20))
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Button(action: {
                    isShowingEmotion = true
                    selectedEmotions = entries.emotions
                }) {
                    Text("\(changeEmotionsText())")
                        .lineLimit(2)
                        .foregroundStyle(.brandText)
                        .font(SetFont.setFontStyle(.medium, 20))
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            TextField("Title", text: $entries.title)
                .font(SetFont.setFontStyle(.medium, 22))
                .padding()
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
            
            ZStack(alignment: .topLeading) {
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(UIColor.systemGray6))
                    .padding(.horizontal)
                
                if entries.body.isEmpty {
                    Text(placeholderText)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.top, 16)
                        .padding(.leading, 32)
                        .font(.body)
                }
                
                TextEditor(text: $entries.body)
                    .scrollContentBackground(.hidden)
                    .font(SetFont.setFontStyle(.regular, 18))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            
            Spacer()
                .toolbar(.hidden, for: .tabBar)
        }
        .background(Color.background)
        .navigationBarTitle("Edit Journal Entry", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    do {
                        try modelContext.save()
                        dismiss()
                    }
                    catch {
                        print("Failed to save: \(error)")
                    }
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
        }
        .navigationDestination(isPresented: $isShowingEmotion) {
            EmotionsView(journalItem: entries)
        }
        .navigationDestination(isPresented: $isShowingMood) {
            SelectMood(journalItem: entries)
        }
    }
    
    func changeMoodText() -> String {
        if selectedMood == nil {
            return "Add Mood"
        } else {
            return "\(entries.mood)"
        }
    }
    
    func changeEmotionsText() -> String {
        if selectedMood == nil {
            return "Add Emotions"
        } else {
            return "\(entries.emotions.joined(separator: ", "))"
        }
    }
    
}
