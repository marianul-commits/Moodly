//
//  EmotionsView.swift
//  Moodly
//
//  Created by Marian Nasturica on 19.07.2024.
//

import SwiftUI

class EmotionsViewModel: ObservableObject {
    @Published var selectedEmotions = [String]()
    @Published var selectedSphere = [String]()
}

struct EmotionsView: View {
    @ObservedObject var viewModel = EmotionsViewModel()
    
    let emotions = [
        ["Excited", "Relaxed", "Proud", "Hopeful"],
        ["Happy", "Enthusiastic", "Refreshed", "Gloomy"],
        ["Lonely", "Anxious", "Sad", "Angry", "Tired"],
        ["Annoyed", "Burdensome", "Bored", "Stressed"]
    ]
    
    let sphere = [
        ["Work", "Friends", "Love", "Family"],
        ["Personal", "Health", "Finance", "Leisure"]
    ]
    
    let sphereImage: [String: String] = [
        "Work": "💼",
        "Friends": "🫂",
        "Love": "❤️",
        "Family": "🧑‍🧑‍🧒",
        "Personal": "🔒",
        "Health": "🩺",
        "Finance": "💵",
        "Leisure": "🧶",
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                Text("Emotions")
                    .font(SetFont.setFontStyle(.medium, 20))
                    .padding(.vertical, 15)
                ForEach(emotions, id: \.self) { row in
                    HStack(spacing: 2) {
                        Spacer()
                        ForEach(row, id: \.self) { emotion in
                            Text(emotion)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 10)
                                .font(SetFont.setFontStyle(.regular, 12))
                                .background(viewModel.selectedEmotions.contains(emotion) ? Color.brandPrimary : Color.gray.opacity(0.2))
                                .cornerRadius(15)
                                .scaleEffect(viewModel.selectedEmotions.contains(emotion) ? 1.1 : 1.0) // Slightly larger when selected
                                .offset(x: viewModel.selectedEmotions.contains(emotion) ? 5 : 0) // Jiggle effect
                                .onTapGesture {
                                    withAnimation {
                                        if let index = viewModel.selectedEmotions.firstIndex(of: emotion) {
                                            viewModel.selectedEmotions.remove(at: index)
                                        } else {
                                            viewModel.selectedEmotions.append(emotion)
                                        }
                                    }
                                }
                                .modifier(FloatyEffect()) // Apply floaty effect
                        }
                        .padding(.horizontal, 5)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                }
                Text("Sphere of life")
                    .font(SetFont.setFontStyle(.medium, 20))
                    .padding(.vertical, 15)
                
                ForEach(sphere, id: \.self) { row in
                    HStack(spacing: 2) {
                        Spacer()
                        ForEach(row, id: \.self) { sphere in
                            VStack{
                                if let imageName = sphereImage[sphere] {
                                    Text(imageName)
                                }
                                Text(sphere)
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 10)
                                    .font(SetFont.setFontStyle(.regular, 12))
                                    .onTapGesture {
                                        withAnimation {
                                            if let index = viewModel.selectedSphere.firstIndex(of: sphere) {
                                                viewModel.selectedSphere.remove(at: index)
                                            } else {
                                                viewModel.selectedSphere.append(sphere)
                                            }
                                        }
                                    }.modifier(FloatyEffect())
                            }
                            .frame(width: 80, height: 80)
                            .padding(.vertical, 5)
                            .background(viewModel.selectedSphere.contains(sphere) ? Color.brandPrimary : Color.gray.opacity(0.2))
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 5)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                }
                Spacer()
                Button {
//                    dismiss()
                } label: {
                    HStack(alignment: .firstTextBaseline){
                        Text("Next")
                            .font(SetFont.setFontStyle(.medium, 18))
                        Image(systemName: "arrow.right")
                    }
                }
                .frame(width: (UIScreen.current?.bounds.width)! - 60, height: 40)
                .background(Color.cyan)
                .tint(Color.brandBlack)
                .clipShape(Capsule())
                .padding()
                
            }
            .padding()
        }
    }
}

// Modifier for floaty effect
struct FloatyEffect: ViewModifier {
    @State private var verticalOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .offset(y: verticalOffset)
            .onAppear {
                verticalOffset = -10
            }
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
                    .speed(0.2),
                value: verticalOffset
            )
    }
}


#Preview {
    EmotionsView()
}
