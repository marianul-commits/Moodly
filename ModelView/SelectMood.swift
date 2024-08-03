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
                                }
                                .overlay(
                                    Group {
                                        if selectionText == moodArrayTxt[index] {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.blue)
                                                .offset(x: 50, y: -50) // Position the checkmark in the top-right corner
                                        }
                                    }
                            )
                            Text(moodArrayTxt[index])
                                .font(SetFont.setFontStyle(.medium, 18))
                                .padding(.vertical, 2)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
                
                
                
                Button {
                    saveMood()
                    dismiss()
                } label: {
                    HStack(alignment: .firstTextBaseline){
                            Text("Next")
                                .font(SetFont.setFontStyle(.medium, 18))
                                .foregroundStyle(.brandBlack)
                            Image(systemName: "arrow.right")
                    }
                    .frame(width: (UIScreen.current?.bounds.width)! - 60, height: 40)
                    .background(Color.cyan)
                    .tint(Color.brandBlack)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
    }
    
    private func saveMood() {
        journalItem.mood = selectionText
    }
    
}

//#Preview {
//    SelectMood()
//}
