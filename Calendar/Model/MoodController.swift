//
//  MoodController.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import Foundation

class MoodModelController: ObservableObject {
    
    //MARK: - Properties
    @Published var moods: [Mood] = []
        
    init() {
        loadFromPersistentStore()
    }
    
    
    //MARK: - CRUD Functions
    func createMood(emotion: Emotion, comment: String?, date: Date, timeOfDay: TimeOfDay) {
        let newMood = Mood(emotion: emotion, comment: comment, date: date, timeOfDay: timeOfDay)
        
        // Check if there are already have 3 moods for this day
        let calendar = Calendar.current
        let existingMoodsForDay = moods.filter { calendar.isDate($0.date, inSameDayAs: date) }
        
        if existingMoodsForDay.count < 3 {
            // Check if a mood for this time of day already exists
            if let existingIndex = existingMoodsForDay.firstIndex(where: { $0.timeOfDay == timeOfDay }) {
                // Replace the existing mood
                if let index = moods.firstIndex(where: { $0 == existingMoodsForDay[existingIndex] }) {
                    moods[index] = newMood
                }
            } else {
                // Add new mood
                moods.append(newMood)
            }
            saveToPersistentStore()
        }
    }
    
    func deleteMood(at offset: IndexSet) {
        guard let index = Array(offset).first else { return }
        moods.remove(at: index)
        saveToPersistentStore()
    }
    
    func clearMood(date: Date, timeOfDay: TimeOfDay) {
        let calendar = Calendar.current
        moods.removeAll { mood in
            calendar.isDate(mood.date, inSameDayAs: date) && mood.timeOfDay == timeOfDay
        }
        saveToPersistentStore()
    }
    
    func removeAll() {
        moods.removeAll()
        saveToPersistentStore()
    }
    
    func updateMoodComment(mood: Mood, comment: String) {
        if let index = moods.firstIndex(of: mood) {
            var mood = moods[index]
            mood.comment = comment
            
            moods[index] = mood
            saveToPersistentStore()
        }
    }
    
    // MARK: Save, Load from Persistent
    private var persistentFileURL: URL? {
      let fileManager = FileManager.default
      guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
       
      return documents.appendingPathComponent("mood.plist")
    }
    
    func saveToPersistentStore() {
        
        // Stars -> Data -> Plist
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(moods)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Stars
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            moods = try decoder.decode([Mood].self, from: data)
        } catch {
            print("error loading stars data: \(error)")
        }
    }
    
}
