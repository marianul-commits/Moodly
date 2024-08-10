//
//  SelectMood.swift
//  Moodly
//
//  Created by Marian Nasturica on 03.08.2024.
//

import SwiftUI

struct SelectMood: View {
    @State var moodArrayImg = ["angryFace", "sadFace", "anxiousFace", "relaxedFace", "happyFace"]
    @State var moodArrayTxt = ["Angry", "Sad", "Anxious", "Relaxed", "Happy"]
    @State var selectionText = ""
    @Environment(\.dismiss) private var dismiss
    @Bindable var journalItem: JournalItem


    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack {
                TabView {
                    ForEach(0..<moodArrayImg.count, id: \.self) { index in
                        VStack {
                            Image(moodArrayImg[index])
                                .resizable()
                                .frame(width: 150, height: 180)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    selectionText = moodArrayTxt[index]
                                    saveMood()
                                    dismiss()
                                }
                            Text(moodArrayTxt[index])
                                .font(SetFont.setFontStyle(.medium, 20))
                                .padding(.vertical, 2)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
            }
        }
    }
    
    private func saveMood() {
        journalItem.mood = selectionText
    }
    
}
