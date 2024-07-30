//
//  Calendar.swift
//  Moodly
//
//  Created by Marian Nasturica on 20.07.2024.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var moodModelController = MoodModelController()
    @State private var showMood = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.background.ignoresSafeArea()
                CalendarsV(start: Date(), monthsToShow: 1, daysSelectable: false, moodController: moodModelController)
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            VStack {
                                Text("Calendar")
                                    .padding(.horizontal, 5)
                                    .font(SetFont.setFontStyle(.bold, 32))
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showMood = true
                            } label: {
                                Image(systemName: "plus")
                                    .offset(x: -4)
                            }.frame(width: 35, height: 35)
                                .background(Color.brandGreen)
                                .tint(Color.brandBlack)
                                .clipShape(Circle())
                                .padding()
                        }
                    }
            }
            .sheet(isPresented: $showMood) {
                MoodView(moodModelController: MoodModelController())
                    .presentationDetents(
                        [.height(350)])
            }
        }
        }
    }
    
    struct CalendarView_Preview: PreviewProvider {
        static var previews: some View {
            CalendarView()
        }
    }
    
