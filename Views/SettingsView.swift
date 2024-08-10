//
//  Settings.swift
//  Moodly
//
//  Created by Marian Nasturica on 20.07.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var darkMode = false
    @State private var showAlert = false
    @State private var showUsername = false
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @AppStorage("username") var username = ""
    @ObservedObject var moodModelController: MoodModelController
        
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                Toggle("Dark Mode", isOn: $isDarkMode)
                    .padding()
                
                Button("Change username") {
                    showUsername = true
                }
                .foregroundStyle(.brandText)
                .frame(width: 200, height: 50)
                .background(.brandPrimary)
                .clipShape(Capsule())
                .padding()
                .alert("What would you like to be called?", isPresented: $showUsername) {
                    TextField("Enter your name", text: $name)
                    Button("OK") {
                        // set new name
                        UserDefaults.standard.set(name, forKey: "username")
                    }
                    Button("Cancel", role: .cancel) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .onAppear {
                    name = UserDefaults.standard.string(forKey: "username") ?? ""
                }
                
                Button("Remove all data") {
                    showAlert = true
                }
                .foregroundStyle(.brandText)
                .frame(width: 200, height: 50)
                .background(.brandDanger)
                .clipShape(Capsule())
                .padding()
                .alert("Are you sure you want to delete all data?", isPresented: $showAlert) {
                    Button("Yes") {
                        moodModelController.removeAll()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("No", role: .cancel) {}
                }
                
            }
        }
    }
}

#Preview {
    SettingsView(moodModelController: MoodModelController())
}
