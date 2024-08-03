//
//  ButtonPopOver.swift
//  Moodly
//
//  Created by Marian Nasturica on 03.08.2024.
//

import SwiftUI

struct ButtonPopOver: View {
    
    @State private var menu = ["Add Pixel", "Add Journal Entry"]
    @State private var selection: String?
    @State private var showMood = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.background.opacity(0.4)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 150)
                .foregroundStyle(Color.clear)
                .overlay(
                    List(menu, id: \.self, selection: $selection) { item in
                        Text(item)
                            .onTapGesture {
                                if selection == "Add Pixel" {
                                    print("i go to calendar")
//                                    dismiss()
                                } else {
                                    print("i go to journal")
                                    dismiss()
                                }
                                
                            }
                    }
                )
        }
    }
}

#Preview {
    ButtonPopOver()
}
