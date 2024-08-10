//
//  HomeView.swift
//  Moodly
//
//  Created by Marian Nasturica on 10.07.2024.
//

import SwiftUI

struct LoginPage: View {
    
    @ObservedObject var userManager: UserManager
    @State private var username = ""
    @State private var showFields = false
    @State private var toggleEnabled = true
    @State private var navigateToHome = false
    @State private var warningToggle = false
    @State private var hideTabBar = false
    @ObservedObject var moodModelController = MoodModelController()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.brandPrimary, .brandPink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
                VStack{
                    Text("Moodly")
                        .font(.custom("Bellota-Bold", size: 48))
                        .fontWeight(.black)
                        .padding(.bottom, 20)
                    
                    if showFields {
                        TextField("What should we call you?", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .opacity(0.6)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .opacity(showFields ? 1 : 0)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .animation(.easeInOut(duration: 1).delay(1.5), value: showFields)
                            .overlay(
                                Group{
                                    if warningToggle == true {
                                        Text("Username field cannot be empty")
                                            .foregroundStyle(warningToggle ? .red : .clear)
                                            .font(.caption)
                                            .offset(x: -80, y: 25)
                                            .padding()
                                            .onAppear {
                                                withAnimation(.linear(duration: 0.01).delay(2)) {
                                                    warningToggle.toggle()
                                                }
                                            }
                                    }
                                }
                            )
                        
                        Button("Continue") {
                            if !username.isEmpty {
                                userManager.login(username: username)
                            } else {
                                warningToggle = true
                            }
                        }
                        .padding(15)
                        .frame(width: 150, height: 40)
                        .tint(.brandText)
                        .background(.brandPrimary)
                        .clipShape(Capsule())
                        .opacity(showFields ? 1 : 0)
                        .animation(.easeInOut(duration: 1).delay(1.5), value: showFields)
                        
                    }
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            showFields = true
                            toggleEnabled = false
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToHome){
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
