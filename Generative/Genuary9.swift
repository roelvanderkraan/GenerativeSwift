//
//  Genuary9.swift
//  Generative
//
//  Created by Roel van der Kraan on 09/01/2025.
//

import SwiftUI

// https://editor.p5js.org/lzmunch/sketches/Xnp94GpqN
struct Genuary9: View {
    var columns = 8
    var columnSpacer = -80.0
    @State private var redrawTrigger = UUID() // Triggers a redraw when updated
    
    
    
    var body: some View {
        let colorNoiseDark = color(red: 26, green: 81, blue: 130)
        let colorNoise1 = color(red: 106, green: 162, blue: 209)
        let colorNoise2 = color(red: 106, green: 162, blue: 209)
        let colorBackground = color(red: 58, green: 112, blue: 159)
        let colorBackground2 = color(red: 100, green: 155, blue: 205)
        ZStack {
            MeshGradient(width: 3, height: 3, points: [
                .init(0, 0), .init(0.5, 0), .init(1, 0),
                .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
                .init(0, 1), .init(0.5, 1), .init(1, 1)
            ], colors: [
                colorBackground2, colorBackground2, colorBackground,
                colorBackground, colorBackground2, colorBackground,
                colorBackground, colorBackground, colorBackground
            ])
            .modifier(RandomNoiseShader())
            Canvas { context, size in
                //createFibers(in: &context, size: size, color: colorBackground)
                //createFibers(in: &context, size: size, color: colorNoise2)
                createFabric(in: &context, size: size, color: colorNoise1)
                createFabric(in: &context, size: size, color: colorNoise2)
                createFabric(in: &context, size: size, color: colorBackground)
                createFibers(in: &context, size: size, color: colorNoiseDark, isAngular: false)
                
                createDots(in: &context, size: size, color: colorNoiseDark)
                createFibers(in: &context, size: size, color: colorNoise1, isAngular: false)
            }
            
        }
        .ignoresSafeArea()
        .background(color(red: 58, green: 112, blue: 159))
        .id(redrawTrigger) // Causes the Canvas to redraw when updated
        .onAppear {
            // Start a timer to trigger redraw every 5 seconds
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                redrawTrigger = UUID() // Change the ID to force a redraw
            }
        }
        
    }
    
    func createFabric(in context: inout GraphicsContext, size: CGSize, color: Color){
        let numFibers = Int.random(in: 100...400);
        for _ in 0..<numFibers {
            let pointx = CGFloat.random(in: 0...1) * size.width
            let pointy = CGFloat.random(in: 0...1) * size.height
            let x1: CGFloat = pointx - size.width / 2
            let y1: CGFloat = pointy - size.height / 2
            let x2 = x1 + size.width;
            let y2 = y1 + size.height;
            var path = Path()
            
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y2))
            context.opacity = CGFloat.random(in: 0.4...0.5)
            context.stroke(path, with: .color(color), lineWidth: CGFloat.random(in: 1...2))
            
            path.move(to: CGPoint(x: x1, y: y2))
            path.addLine(to: CGPoint(x: x2, y: y1))
            context.opacity = CGFloat.random(in: 0.4...0.5)
            context.stroke(path, with: .color(color), lineWidth: CGFloat.random(in: 1...2))
        }
        
    }
    
    func createDots(in context: inout GraphicsContext, size: CGSize, color: Color) {
        let numRows = Int.random(in: 30...50);
        let numCols = Int.random(in: 30...40);
        let ySpacing = size.height / CGFloat(numRows-1);
        let xspacing = size.width / CGFloat(numCols-1);
        let ovalSize = CGSize(width: 8.0, height: 8.0)
        let accentChange = Float.random(in: 0.95...0.997)
        let accentColor: [Color] = [self.color(red: 241, green: 232, blue: 233), self.color(red: 240, green: 169, blue: 114)]
        var x = -xspacing / 1;
        var y = -ySpacing;
        for row in 0..<numRows {
            for col in 0..<numCols {
                context.opacity = CGFloat.random(in: 0.5...0.8)
                
                
                if accentChange.isLessThanOrEqualTo(Float.random(in: 0...1)) {
                    let randomSize = CGFloat.random(in: 15...50)
                    let accentSize = CGSize(width: randomSize, height: randomSize)
                    context.fill(
                        Path(ellipseIn: CGRect(origin: CGPoint(x: x, y: y), size: accentSize)),
                        with: .color(accentColor.randomElement()!))
                } else {
                    context.fill(
                        Path(ellipseIn: CGRect(origin: CGPoint(x: x, y: y), size: ovalSize)),
                        with: .color(color))
                }
                x += xspacing;
            }
            if row.isMultiple(of: 2) {
                x = -xspacing
            } else {
                x = xspacing / 2
            }
            y += ySpacing;
        }
    }
    
    func createFibers(in context: inout GraphicsContext, size: CGSize, color: Color, isAngular: Bool = true){
      let numFibers = 30000;
        for _ in 0..<numFibers {
          let x1 = CGFloat.random(in: 0...1) * size.width
          let y1 = CGFloat.random(in: 0...1) * size.height
          var theta = CGFloat.random(in: 0...1) * 2 * CGFloat.pi;
            if !isAngular
                {theta = 0}
        let segmentLength = CGFloat.random(in: 1...2) * 2 + 4
        let x2 = cos(theta) * segmentLength + x1;
        let y2 = sin(theta) * segmentLength + y1;
            var path = Path()

            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y2))
            context.opacity = CGFloat.random(in: 0.2...0.5)
            context.stroke(path, with: .color(color), lineWidth: CGFloat.random(in: 1...2))
        }
    }

    func createBackground(in context: GraphicsContext, size: CGSize) {
    }

    private func color(red: Int, green: Int, blue: Int) -> Color {
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255

        return Color(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue)
    }
    
    struct RandomNoiseShader: ViewModifier {
        
        let startDate = Date()
        
        func body(content: Content) -> some View {
            TimelineView(.animation) { _ in
                content
                    .colorEffect(
                        ShaderLibrary.randomNoise(
                            .float(1)
                        )
                    )
                    .opacity(0.1)
            }
        }
    }

}


#Preview {
    Genuary9()
}
