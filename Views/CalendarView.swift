//
//  Calendar.swift
//  Moodly
//
//  Created by Marian Nasturica on 20.07.2024.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var moodModelController: MoodModelController
    @State private var showMood = false
    @State private var showRemoveMood = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack{
                    CalendarHelper(moodModelController: moodModelController, startDate: Date(), monthsToDisplay: 1, selectableDays: false)
                        .padding()
                        .safeAreaPadding(.top, 20)
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
                                    showRemoveMood = true
                                } label: {
                                    Image(systemName: "minus")
                                }
                                .frame(width: 35, height: 35)
                                .contentShape(Rectangle())
                                .background(Color.brandGreen)
                                .tint(Color.brandBlack)
                                .clipShape(Circle())
                                .padding()
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showMood = true
                                } label: {
                                    Image(systemName: "plus")
                                        .offset(x: -4)
                                }
                                .frame(width: 35, height: 35)
                                .contentShape(Rectangle())
                                .background(Color.brandGreen)
                                .tint(Color.brandBlack)
                                .clipShape(Circle())
                                .padding()
                            }
                        }
                }
            }
            .sheet(isPresented: $showRemoveMood) {
                MoodRemoveView(moodModelController: moodModelController)
                    .presentationDetents([.height(430)])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showMood) {
                MoodView(moodModelController: moodModelController)
                    .presentationDetents([.height(430)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView(moodModelController: MoodModelController())
    }
}

