//
//  ContentView.swift
//  Moodly
//
//  Created by Marian Nasturica on 10.07.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selectedTab = 0
    @State private var hideTabBar = false
    @ObservedObject var moodModelController = MoodModelController()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView(moodModelController: moodModelController, day: Day(date: Date()))
                    .tag(0)
                
                CalendarView(moodModelController: moodModelController)
                    .tag(1)
                
                JournalView(hideTabBar: $hideTabBar)
                    .tag(2)
                
                SettingsView(moodModelController: moodModelController)
                    .tag(3)
            }
            
            if !hideTabBar {
                customTabBar
            }
        }
    }
    
    var customTabBar: some View {
        TabBarCustomization()
            .fill(Color.brandPrimary.opacity(0.8))
            .frame(width: UIScreen.current!.bounds.width - 15, height: 65)
            .overlay(
                HStack(alignment: .lastTextBaseline, spacing: 20) {
                    tabButton(tab: 0, imageName: "house.fill", text: "Home")
                        .padding(.horizontal, 8)
                    tabButton(tab: 1, imageName: "calendar", text: "Calendar")
                        .padding(.horizontal, 8)
                    tabButton(tab: 2, imageName: "book.pages.fill", text: "Journal")
                        .padding(.horizontal, 8)
                    tabButton(tab: 3, imageName: "gear", text: "Settings")
                        .padding(.horizontal, 8)
                }
            )
            .background(.clear)
            .padding(.horizontal)
    }
    
    func tabButton(tab: Int, imageName: String, text: String) -> some View {
        Button(action: { selectedTab = tab }) {
            VStack {
                Image(systemName: imageName)
                    .padding(.vertical, 2)
                    .foregroundColor(selectedTab == tab ? Color.brandPink : Color.white)
                Text(text)
                    .font(SetFont.setFontStyle(.regular, 15))
                    .tint(selectedTab == tab ? Color.brandPink : Color.brandText)
            }
        }
    }
}

#Preview {
    ContentView()
}
