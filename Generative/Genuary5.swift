//
//  ContentView.swift
//  Generative
//
//  Created by Roel van der Kraan on 04/01/2025.
//

import SwiftUI

struct Genuary5: View {
    // https://genuary.art/prompts#jan4
    // isomatric art no vanashing points
    // https://swiftwithmajid.com/2023/04/11/mastering-canvas-in-swiftui/
    //https://happycoding.io/tutorials/p5js/creating-classes/isometric-cubes
    //https://swiftui-lab.com/swiftui-animations-part4/
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-metal-shaders-to-swiftui-views-using-layer-effects
    //https://github.com/dejager/wallpaper/
    @State private var cubeSize: CGFloat = 45
   private let animationDuration: Double = 2.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                
                let rows = 9
                let columns = 9
                let startX: CGFloat = size.width / 2
                let startY: CGFloat = cubeSize
                for row in 0..<rows {
                    for column in 0..<columns {
                        let xOffset = CGFloat(column - row) * cubeSize  * (10 * sin(now * 0.5)) * 0.25
                        let yOffset = CGFloat(row + column) * cubeSize * 0.5
                        let zOffset = CGFloat(row + column) * cubeSize
                        
                        let cubeOrigin = CGPoint(x: startX + xOffset, y: startY + yOffset + zOffset)
                        drawIsometricCube(context: &context, origin: cubeOrigin, size: cubeSize)
                    }
                }
                
            }
        }
        .background(color(red: 125, green: 76, blue: 152))
        .ignoresSafeArea()
    }
    
    private func drawIsometricCube(context: inout GraphicsContext, origin: CGPoint, size: CGFloat) {
        let frontColor = color(red: 105, green: 192, blue: 176)
        let sideColor = color(red: 43, green: 40, blue: 41)
        let topColor = color(red: 237, green: 236, blue: 234)

               // Calculate points for the isometric cube
               let p1 = origin
               let p2 = CGPoint(x: origin.x + size, y: origin.y - size * 0.5)
               let p3 = CGPoint(x: origin.x, y: origin.y - size)
               let p4 = CGPoint(x: origin.x - size, y: origin.y - size * 0.5)
               let p5 = CGPoint(x: origin.x + size, y: origin.y + size * 0.5)
               let p6 = CGPoint(x: origin.x, y: origin.y + size)
               let p7 = CGPoint(x: origin.x - size, y: origin.y + size * 0.5)

               // Draw top face
               var topFace = Path()
               topFace.move(to: p1)
               topFace.addLine(to: p2)
               topFace.addLine(to: p3)
               topFace.addLine(to: p4)
               topFace.closeSubpath()
               context.fill(topFace, with: .color(topColor))

               // Draw front face
               var frontFace = Path()
               frontFace.move(to: p1)
               frontFace.addLine(to: p4)
               frontFace.addLine(to: p7)
               frontFace.addLine(to: p6)
               frontFace.closeSubpath()
               context.fill(frontFace, with: .color(frontColor))

               // Draw side face
               var sideFace = Path()
               sideFace.move(to: p1)
               sideFace.addLine(to: p2)
               sideFace.addLine(to: p5)
               sideFace.addLine(to: p6)
               sideFace.closeSubpath()
               context.fill(sideFace, with: .color(sideColor))
    }
    
    private func color(red: Int, green: Int, blue: Int) -> Color {
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255

        return Color(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue)
    }
    
    
}

#Preview {
    Genuary5()
}
