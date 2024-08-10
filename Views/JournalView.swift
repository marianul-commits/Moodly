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
    @StateObject private var emotions = EmotionsViewModel()
    @Binding var hideTabBar: Bool
    @State private var refreshTrigger = UUID()
    
    var body: some View {
        NavigationStack(path: $path) {
            EntriesView(refreshTrigger: refreshTrigger)
                .navigationDestination(for: JournalItem.self) { item in
                    EditJournal(entries: item, emotions: emotions)
                        .onChange(of: item) { _, _ in
                            refreshTrigger = UUID()
                        }
                }
                .onAppear {
                    hideTabBar = false
                }
                .onDisappear{
                    hideTabBar = true
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        VStack {
                            Text("Journal")
                                .padding(.horizontal, 5)
                                .font(SetFont.setFontStyle(.bold, 32))
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEntry()
                        } label: {
                            Image(systemName: "plus")
                                .offset(x: -4)
                        }
                        .frame(width: 35, height: 35)
                        .contentShape(Rectangle())
                        .background(Color.brandTurqoise)
                        .tint(Color.brandBlack)
                        .clipShape(Circle())
                        .padding()
                    }
                }
        }
        .onChange(of: path) { _, _ in
            refreshTrigger = UUID()
        }
        .onDisappear{
            hideTabBar = false
        }
    }
    
    
    func addEntry() {
        let newEntry = JournalItem()
        modelContext.insert(newEntry)
        do {
            try modelContext.save()
            path = [newEntry]
            refreshTrigger = UUID()
        } catch {
            print("Failed to save new entry: \(error)")
        }
    }
}


//#Preview {
//    JournalView()
//}

struct JournalView_Preview: PreviewProvider {
    @State static var dummyBar = false
    
    static var previews: some View{
        JournalView(hideTabBar: $dummyBar)
    }
}
