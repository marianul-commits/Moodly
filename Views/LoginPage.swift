//
//  HomeView.swift
//  Moodly
//
//  Created by Marian Nasturica on 10.07.2024.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showFields = false
    @State private var toggleEnabled = true

    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.clear)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.brandPrimary, .brandPink]), startPoint: .top, endPoint: .bottom)
            )
            
            VStack{
                Text("Moodly")
                    .font(.custom("Bellota-Bold", size: 48))
                    .fontWeight(.black)
                    .padding(.bottom, 20)
                
                if showFields {
                    TextField("What should we call you?", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .opacity(0.6)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .opacity(showFields ? 1 : 0)
                        .animation(.easeInOut(duration: 1).delay(1.5), value: showFields)
                                 
                    Button("Create Account") {
                    }
                    .padding(10)
                    .tint(.brandBlack)
                    .background(.brandGreen)
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
    }
}

#Preview {
    LoginPage()
}
