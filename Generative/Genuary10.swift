//
//  Genuary10.swift
//  Generative
//
//  Created by Roel van der Kraan on 10/01/2025.
//

import SwiftUI

struct Genuary10: View {
    @State private var redrawTrigger = UUID() // Triggers a redraw when updated
    
    var tau = Double.pi * 2 // 6.2831855
    
    var body: some View {
        var single = tau / tau
        var halfTau = tau / single + single

        ZStack {
            Text("Genuary 10")
            Canvas { context, size in
                drawCircle(in: &context)
                var columnXStart = tau
                var columnYStart = tau
                for column in Int(tau)..<Int(tau * tau * tau) {
                    for angle in stride(from: tau, to: tau*tau*tau*tau, by: halfTau) {
                        var x = columnXStart + sin(angle) * tau
                        var y = columnYStart + cos(angle) * tau
                        let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: halfTau, height: tau*tau)).applying(.init(rotationAngle: angle))
                        let circle = Ellipse()
                        let circlePath = circle.path(in: rect)
                        context.fill(circlePath, with: .color(.black))
                    }
                    columnXStart += tau + Double.random(in: single...halfTau)
                    columnYStart = tau
                }
                
            }
        }
        .ignoresSafeArea()
        
    }
    
    func drawCircle(in context: inout GraphicsContext) {
        let rect = CGRect(origin: CGPoint(x: tau, y: tau), size: CGSize(width: tau, height: tau))
        let circle = Circle()
        let circlePath = circle.path(in: rect)
        context.fill(circlePath, with: .color(.black))
    }
}

#Preview {
    Genuary10()
}
