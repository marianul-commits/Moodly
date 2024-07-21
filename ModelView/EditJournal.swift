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
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    @State private var placeholderText: String = "How are you feeling?"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button(action: {
                    // First button action
                }) {
                    Text("Add Mood")
                        .font(SetFont.setFontStyle(.medium, 20))
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Button(action: {
                    // Second button action
                }) {
                    Text("Emotions")
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
        }
        .background(Color.background)
        .navigationBarTitle("Edit Journal Entry", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
            
        }
        
    }
}


#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: JournalItem.self, configurations: config)
        let example = JournalItem(id: UUID(), title: "This is a testy test", body: "TestyMcTest is testing the test while doing tests", date: .now, mood: "Meh", emotions: ["Bored"])
        return EditJournal(entries: example)
            .modelContainer(container)
    }
    catch{
        fatalError("OOpsie daisy")
    }
}
