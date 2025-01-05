//
//  Genuary6.swift
//  Generative
//
//  Created by Roel van der Kraan on 05/01/2025.
//

import SwiftUI

struct Genuary6: View {
    var body: some View {
        var currentX = 5.0
        var currentY = 0.0
        var innerRadius = 500.0
        var outerRadius = 1200.0
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                let centerXOuter = size.width / 2 - outerRadius / 2
                let centerYOuter = size.height / 2
                let centerX = size.width / 2 - innerRadius / 2
                let centerY = centerYOuter + (outerRadius / 17)
                
                let rectOuter = CGRect(origin: CGPoint(x: centerXOuter, y: centerYOuter), size: CGSize(width: outerRadius, height: outerRadius/3))
                var pathOuter = Ellipse().path(in: rectOuter)
                context.fill(pathOuter, with: .color(color(red: 0, green: 87, blue: 83)))
                
               
                
                let rectInner = CGRect(origin: CGPoint(x: centerX, y: centerY), size: CGSize(width: innerRadius, height: innerRadius/3))
                var pathInner = Ellipse().path(in: rectInner)
                context.fill(pathInner, with: .color(color(red: 7, green: 180, blue: 185)))
                
                
            }
        }
        .ignoresSafeArea()
    }
    
    private func color(red: Int, green: Int, blue: Int) -> Color {
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255

        return Color(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue)
    }
}

#Preview {
    Genuary6()
}
