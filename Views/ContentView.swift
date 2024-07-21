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
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                ContentView2(calendar: Calendar.current)
                    .tag(1)
                
                JournalView()
                    .tag(2)
                
                SettingsView()
                    .tag(3)
            }
        }
        
        ZStack {
            //Workaround to fix whitespace caused by TabView
            Color.background.ignoresSafeArea()
                .frame(width: UIScreen.current?.bounds.width, height: 65)
                .offset(x:0 ,y: -10)
            Color.background.ignoresSafeArea()
                .frame(width: UIScreen.current?.bounds.width, height: 65)
            TabBarCustomization()
                .fill(Color.brandGreen.opacity(0.9))
                .frame(width: UIScreen.current!.bounds.width - 15, height: 65)
                .overlay(
                    HStack(alignment: .lastTextBaseline) {
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 0
                        }) {
                            VStack{
                                Image(systemName: "house.fill")
                                    .padding(.vertical, 2)
                                    .foregroundColor(selectedTab == 0 ? Color.brandPink : Color.white)
                                Text("Home")
                                    .font(SetFont.setFontStyle(.regular, 15))
                                    .tint(selectedTab == 0 ? Color.brandPink : Color.brandBlack)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack{
                                Image(systemName: "calendar")
                                    .padding(.vertical, 2)
                                    .foregroundColor(selectedTab == 1 ? Color.brandPink : Color.white)
                                Text("Calendar")
                                    .font(SetFont.setFontStyle(.regular, 15))
                                    .tint(selectedTab == 1 ? Color.brandPink : Color.brandBlack)
                            }
                        }
                        
                        Spacer()
                        Button(action: {
                            // Action
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.brandTurqoise)
                                    .frame(width: 55, height: 55)
                                    .shadow(color: Color.green.opacity(0.4), radius: 10, x: 0, y: 0)
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                            }
                        }
                        .offset(x: 0, y: -30)
                        
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack{
                                Image(systemName: "book.pages.fill")
                                    .padding(.vertical, 2)
                                    .foregroundColor(selectedTab == 2 ? Color.brandPink : Color.white)
                                Text("Journal")
                                    .font(SetFont.setFontStyle(.regular, 15))
                                    .tint(selectedTab == 2 ? Color.brandPink : Color.brandBlack)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 3
                        }) {
                            VStack{
                                Image(systemName: "gear")
                                    .padding(.vertical, 2)
                                    .foregroundColor(selectedTab == 3 ? Color.brandPink : Color.white)
                                Text("Settings")
                                    .font(SetFont.setFontStyle(.regular, 15))
                                    .tint(selectedTab == 3 ? Color.brandPink : Color.brandBlack)
                            }
                        }
                        Spacer()
                    }
                )
        }
        .padding(.horizontal)

    }
}

#Preview {
    ContentView()
}
