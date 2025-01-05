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
        var triangleSize = 1000.0
        var outerRadius = 1200.0
        var columns = 10
        var columnSpacer = -80.0
        var brightness = 0.0
//        TimelineView(.animation) { timeline in
//            let now = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                var centerY = size.height - triangleSize
                
                triangleSize = 1000.0
                centerY = size.height - triangleSize
                
               
                for loopCount in (0..<columns) {
                    let centerX = -triangleSize + (Double(loopCount) * triangleSize*0.5 + columnSpacer)
                    let height = triangleSize * Double.random(in: 0.3...1)
                    
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY + (triangleSize - height)), size: CGSize(width: triangleSize, height: height))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 220, green: 213, blue: 235)))
                }
                
                triangleSize = 900.0
                centerY = size.height - triangleSize
                
                for loopCount in (0..<columns) {
                    let centerX = -600 + (Double(loopCount) * triangleSize * 0.8 + columnSpacer)
                    let height = triangleSize * Double.random(in: 0.3...1)
                    
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY + (triangleSize - height)), size: CGSize(width: triangleSize, height: height))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 167, green: 176, blue: 218)))
                }
                
                triangleSize = 500.0
                centerY = size.height - triangleSize
                
               
                for loopCount in (0..<columns) {
                    let centerX = (Double(loopCount) * triangleSize * 0.8 + columnSpacer)
                    let height = triangleSize * Double.random(in: 0.4...1)
                    
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY + (triangleSize - height)), size: CGSize(width: triangleSize, height: height))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 1, green: 97, blue: 83)))
                }
                
                triangleSize = 340.0
                centerY = size.height - triangleSize
                for loopCount in (0..<columns) {
                    let centerX = -200 + (Double(loopCount) * triangleSize * 0.8 - columnSpacer)
                    let height = triangleSize * Double.random(in: 0.4...1)
                    let rect = CGRect(origin: CGPoint(x: centerX, y: centerY + (triangleSize - height)), size: CGSize(width: triangleSize, height: height))
                    var trianglePaths = Triangle().path(in: rect)
                    context.fill(trianglePaths, with: .color(color(red: 0, green: 87, blue: 83)))
                }
                
                
                
//            }
        }
        .ignoresSafeArea()
        .background(color(red: 174, green: 220, blue: 245))
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
