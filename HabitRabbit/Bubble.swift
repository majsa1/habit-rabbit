//
//  Bubble.swift
//  HabitRabbit
//
//  Created by Marjo Salo on 12/04/2021.
//

import SwiftUI

struct SpeechBubble: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
    
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control1: CGPoint(x: rect.maxX * 0.9, y: rect.maxY), control2: CGPoint(x: rect.maxX, y: rect.maxY * 0.9))
        p.addCurve(to: CGPoint(x: rect.maxX * 0.8, y: rect.minY), control1: CGPoint(x: rect.maxX, y: rect.maxY * 0.1), control2: CGPoint(x: rect.maxX * 0.9, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX * 0.82, y: rect.maxY * 0.05))
        p.addCurve(to: CGPoint(x: rect.minX, y: rect.midY), control1: CGPoint(x: rect.maxX * 0.2, y: rect.minY), control2: CGPoint(x: rect.minX, y: rect.maxY * 0.1))
        p.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control1: CGPoint(x: rect.minX, y: rect.maxY * 0.9), control2: CGPoint(x: rect.maxX * 0.1, y: rect.maxY))
        
        return p
    }
}


struct Bubble: View {
    var body: some View {
        SpeechBubble()
            .frame(width: 150, height: 100)
    }
}

struct Bubble_Previews: PreviewProvider {
    static var previews: some View {
        Bubble()
    }
}
