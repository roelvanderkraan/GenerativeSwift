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
        var triangleSize = 400.0
        var outerRadius = 1200.0
        var columns = 10
        var columnSpacer = 24.0
        var brightness = 0.0
//        TimelineView(.animation) { timeline in
//            let now = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                
            var centerY = size.height - triangleSize * 1.5
                for loopCount in (0..<columns) {
                    let centerX = (Double(loopCount) * triangleSize - columnSpacer)
                    
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY), size: CGSize(width: triangleSize, height: triangleSize * Double.random(in: 1...2)))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 30, green: 97, blue: 83)))
                }
                
                centerY = size.height - triangleSize
                
                for loopCount in (0..<columns) {
                    let centerX = -50 + (Double(loopCount) * triangleSize - columnSpacer)
                    
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY), size: CGSize(width: triangleSize, height: triangleSize * Double.random(in: 1...2)))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 0, green: 87, blue: 83)))
                }
                
                
                
//            }
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

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

#Preview {
    Genuary6()
}
