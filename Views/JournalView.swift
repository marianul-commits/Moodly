//
//  JournalView.swift
//  Moodly
//
//  Created by Marian Nasturica on 14.07.2024.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var path = [JournalItem]()
    
    var body: some View {
                NavigationStack(path: $path){
                    EntriesView()
                        .navigationDestination(for: JournalItem.self) { item in
                            EditJournal(entries: item)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                VStack {
                                    Text("Journal")
                                        .padding(.horizontal, 5)
                                        .font(SetFont.setFontStyle(.bold, 38))
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    addEntry()
                                } label: {
                                    Image(systemName: "plus")
                                        .offset(x: -4)
                                    }.frame(width: 40, height: 40)
                                    .background(Color.brandGreen)
                                    .tint(Color.brandBlack)
                                    .clipShape(Circle())
                                    .padding()
                            }
                        }
                }
        }
        
    func addEntry() {
        let newEntry = JournalItem()
        modelContext.insert(newEntry)
        path = [newEntry]
    }
        
}


#Preview {
    JournalView()
}
