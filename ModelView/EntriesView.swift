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
    @Query var entries: [JournalItem]
    
    var body: some View {
        List{
            ForEach(entries) { entry in
                NavigationLink(value: entry) {
                    VStack(alignment: .leading) {
                        Text(entry.title)
                            .font(SetFont.setFontStyle(.medium, 22))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                        Text(entry.body)
                            .font(SetFont.setFontStyle(.regular, 18))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .frame(maxHeight: 200)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                        Text(entry.dateText)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                            .font(SetFont.setFontStyle(.thinItalic, 12))
                    }
                    
                }
                
            }
            .onDelete(perform: deleteEntry)
            
        }
        .scrollContentBackground(.hidden)
        .background(Color.background)

    }
    
    func deleteEntry(_ indexSet: IndexSet) {
        for index in indexSet {
            let entry = entries[index]
            modelContext.delete(entry)
        }
    }
    
}

#Preview {
    EntriesView()
}
