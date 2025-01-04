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
    @State private var cubeSize: CGFloat = 50
   private let animationDuration: Double = 2.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                let rows = 20
                let columns = 20
                let startX: CGFloat = size.width / 2
                let startY: CGFloat = cubeSize
                context.addFilter(.contrast(20.0))
                for row in 0..<rows {
                    for column in 0..<columns {
                        let xOffset = CGFloat(column - row) * cubeSize  * -(now.remainder(dividingBy:4)) * 0.5
                        let yOffset = CGFloat(row + column) * cubeSize * 0.5
                        let zOffset = CGFloat(row + column) * cubeSize
                        
                        let cubeOrigin = CGPoint(x: startX + xOffset, y: startY + yOffset + zOffset)
                        drawIsometricCube(context: &context, origin: cubeOrigin, size: cubeSize)
                    }
                }
                
            }
        }
        .background(Color.black)
        
    }
    
    private func drawIsometricCube(context: inout GraphicsContext, origin: CGPoint, size: CGFloat) {
        let frontColor = Color.blue
        let sideColor = Color.black
        let topColor = Color.pink

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
}

#Preview {
    Genuary5()
}
