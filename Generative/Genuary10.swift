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
    @State var increaseTau = Double.pi * 2
    
    var body: some View {
        var single = tau / tau
        var halfTau = tau / single + single
        
        ZStack {
            Canvas { context, size in
                increaseTau = halfTau / halfTau
                var columnXStart = tau
                var columnYStart = tau
                for column in Int(tau)..<Int(tau * tau * tau) {
                    for angle in stride(from: tau, to: increaseTau*tau, by: halfTau) {
                        var x = columnXStart + sin(angle) * tau
                        var y = columnYStart + cos(angle) * tau
                        let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: halfTau, height: tau*tau)).applying(.init(rotationAngle: angle))
                        let circle = Ellipse()
                        let circlePath = circle.path(in: rect)
                        context.opacity = CGFloat.random(in: single/tau/tau...single/tau)
                        context.fill(circlePath, with: .color(.blue))
                    }
                    columnXStart += tau + Double.random(in: single...halfTau)
                    columnYStart = tau
                }
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // Start a timer to trigger redraw every 5 seconds
            Timer.scheduledTimer(withTimeInterval: tau/tau/tau, repeats: true) { _ in
                increaseTau += halfTau
            }
        }
        
    }
}

#Preview {
    Genuary10()
}
