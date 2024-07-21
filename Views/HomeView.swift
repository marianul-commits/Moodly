//
//  HomeView.swift
//  Moodly
//
//  Created by Marian Nasturica on 12.07.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ZStack {
                VStack{ //Used for pushing the Gradient Rounded Rectangle to the top
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .frame(width: UIScreen.current!.bounds.width, height: (UIScreen.current?.bounds.height)! / 3.2)
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [.brandPrimary, .brandPink]), startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.9))
                            )
                            .shadow(color: .black.opacity(0.2), radius: 10)
                            HStack{
                                Text("Hi Bekky 👋")
                                    .padding(.horizontal, 20)
                                    .font(SetFont.setFontStyle(.medium, 32))
                                Spacer()
                            }
                    }
                    Spacer()
                }
                VStack { // Used for nesting the White Rounded Rectangles
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(.brandWhite)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                        
                        HStack { // Mood Quick Actions
                            Button(action: {
                                print("Angry pressed")
                            }) {
                                Text("😡")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Sad pressed")
                            }) {
                                Text("😢")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Anxious pressed")
                            }) {
                                Text("😬")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Calm pressed")
                            }) {
                                Text("😌")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                print("Happy pressed")
                            }) {
                                Text("😃")
//                                    .font(.caption)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(.brandWhite)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 170)
                            .padding(.vertical, 10)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                        
                        HStack(spacing: 10) { // Days at a glance
                            ForEach(getLast7Days()) { day in
                                VStack(spacing: 5) {
                                    Text(day.dayName)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    
                                    ZStack {
                                        Capsule()
                                            .fill(day.isPast ? Color.yellow.opacity(0.8) : day.isFuture ? Color.gray.opacity(0.8) : Color.gray.opacity(0.2))
                                            .frame(width: 35, height: 85)
                                            .overlay(
                                                VStack {
                                                    Spacer()
                                                    ZStack {
                                                        if day.isToday {
                                                            Circle()
                                                                .fill(Color.pink.opacity(0.8))
                                                                .frame(width: 34, height: 34)
                                                        }
                                                        Text(day.date)
                                                            .font(.body)
                                                            .foregroundColor(.black)
                                                            .padding(.vertical, 7)
                                                    }
                                                }
                                            )
                                    }
                                }
                            }
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundStyle(.brandWhite)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2.5, y: 5)
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerSize: CGSize(width: 10, height:10))
                                    .foregroundStyle(.gray.opacity(0.6))
                                    .frame(width: 50, height: 50)
                                Image(systemName: "pencil.and.scribble")
                                    .padding()
                            }
                            Text("Add an entry for today")
                        }
                    }
                }
                .offset(y: -50)
                .zIndex(1)
            }
        }
        .background(Color.background)
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
