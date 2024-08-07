//
//  EntriesView.swift
//  Moodly
//
//  Created by Marian Nasturica on 16.07.2024.
//

import SwiftUI
import SwiftData

struct EntriesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \JournalItem.date, order: .reverse) var entries: [JournalItem]
    var refreshTrigger: UUID
    
    var body: some View {
        List {
            ForEach(entries) { entry in
                NavigationLink(value: entry) {
                    EntriesViewModel(
                        titles: entry.title,
                        bodys: entry.body,
                        moodzs: entry.mood,
                        emotionsz: entry.emotions,
                        dates: entry.date,
                        moodModelController: MoodModelController()
                    )
                }
                .listRowInsets(EdgeInsets(.init(top: 2, leading: 35, bottom: 2, trailing: 20)))
                .listRowBackground(
                    Color.background
                        .cornerRadius(20)
                )
            }
            .onDelete(perform: deleteEntry)
        }
        .scrollContentBackground(.hidden)
        .background(Color.background)
        .id(refreshTrigger)
    }
    
    func deleteEntry(_ indexSet: IndexSet) {
        for index in indexSet {
            let entry = entries[index]
            modelContext.delete(entry)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete entry: \(error)")
        }
    }
}

//#Preview {
//    EntriesView()
//}
