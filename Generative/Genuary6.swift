//
//  Genuary6.swift
//  Generative
//
//  Created by Roel van der Kraan on 05/01/2025.
//

import SwiftUI

struct Genuary6: View {
    var columns = 8
    var columnSpacer = -80.0

    var body: some View {
        var triangleSize = 1000.0
        
//        TimelineView(.animation) { timeline in
//            let now = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                var centerY = size.height - triangleSize

                triangleSize = 900.0
                let backColor = color(red: 220, green: 213, blue: 235)
                drawMountains(context: &context, size: size, triangleSize: triangleSize, color: backColor)
                
                triangleSize = 800.0
                centerY = size.height - triangleSize
                let thirdColor = color(red: 167, green: 176, blue: 218)
                drawMountains(context: &context, size: size, triangleSize: triangleSize, color: thirdColor)
                
                triangleSize = 600.0
                centerY = size.height - triangleSize
                let secondColor = color(red: 1, green: 97, blue: 83)
                drawMountains(context: &context, size: size, triangleSize: triangleSize, color: secondColor)
            
                triangleSize = 300.0
                let frontColor = color(red: 0, green: 87, blue: 83)
                drawMountains(context: &context, size: size, triangleSize: triangleSize, color: frontColor)
   
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
    
    private func drawMountains(context: inout GraphicsContext, size: CGSize, triangleSize: Double, color: Color) {
        let centerY = size.height - triangleSize
        let xOffset = Double.random(in: 40...600)
        for loopCount in (0..<columns) {
            let centerX = -xOffset + (Double(loopCount) * triangleSize * 0.8 - columnSpacer)
            let height = triangleSize * Double.random(in: 0.4...1)
            drawTriangle(context: &context, size: CGSize(width: triangleSize, height: height), origin: CGPoint(x: centerX, y: centerY + (triangleSize - height)), color: color)
        }
    }
    
    private func drawTriangle(context: inout GraphicsContext, size: CGSize, origin: CGPoint, color: Color) {
        
        let rect = CGRect(origin: origin, size: size)
        let triangle = Triangle()
        let trianglePath = triangle.path(in: rect)
        context.fill(trianglePath, with: .color(color))
        let shadowPath = triangle.shadowPath(in: rect)
        context.fill(shadowPath, with: .color(.black.opacity(0.4)))
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
    
    func shadowPath(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width / 5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

#Preview {
    Genuary6()
}
