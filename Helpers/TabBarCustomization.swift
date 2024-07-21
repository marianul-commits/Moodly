//
//  TabBarCustomization.swift
//  Moodly
//
//  Created by Marian Nasturica on 17.07.2024.
//

import SwiftUI

struct TabBarCustomization: Shape {
    let height: CGFloat = 37.0
    let cornerRadius: CGFloat = 20.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerWidth = rect.width / 2
                
        // Top-left corner
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: centerWidth - height * 2, y: 0))
        
        // First curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      control1: CGPoint(x: centerWidth - 30, y: 0),
                      control2: CGPoint(x: centerWidth - 35, y: height))
        
        // Second curve up
        path.addCurve(to: CGPoint(x: centerWidth + height * 2, y: 0),
                      control1: CGPoint(x: centerWidth + 35, y: height),
                      control2: CGPoint(x: centerWidth + 30, y: 0))
        
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        
        // Top-right corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(270),
                    endAngle: .degrees(360),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
        
        // Bottom-right corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(90),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height))
        
        // Bottom-left corner
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180),
                    clockwise: false)
        
        path.closeSubpath()
        
        return path
    }
}
