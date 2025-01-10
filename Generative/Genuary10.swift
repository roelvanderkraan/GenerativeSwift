//
//  Genuary10.swift
//  Generative
//
//  Created by Roel van der Kraan on 10/01/2025.
//

import SwiftUI

struct Genuary10: View {
    
    @State var increaseTau: Double
    
    var body: some View {
        let tau = Double.pi * 2 // No tau nativly in swifui. 6.2831855
        let single = tau / tau
        let tauPlusSingle = tau + single
        let halfTau = tau / (single + single)
        let colorBlue = self.color(red: Int(tauPlusSingle), green: Int(tau*tau), blue: Int(tau*tau*tau))
        
        ZStack {
            
            Canvas { context, size in
                var columnXStart = tau
                var columnYStart = tau
                for _ in Int(tau)..<Int(tauPlusSingle * tauPlusSingle * tauPlusSingle) {
                    for angle in stride(from: tau, to: increaseTau, by: tauPlusSingle) {
                        let x = columnXStart
                        let y = columnYStart
                        if x > size.width && y > size.height { continue }
                        if x < 0 || y < 0 { continue }
                        let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: halfTau, height: tau+tau)).applying(.init(rotationAngle: angle))
                        let circle = Ellipse()
                        let circlePath = circle.path(in: rect)
                        context.fill(circlePath, with: .color(.white))
                    }
                    columnXStart += tau + Double.random(in: single...tauPlusSingle)
                    columnYStart = tau
                }
                
            }
            .background(colorBlue)
        }
        .ignoresSafeArea()
        .onAppear {
            // Start a timer to trigger redraw every 5 seconds
            Timer.scheduledTimer(withTimeInterval: single/tau/tau, repeats: true) { _ in
                increaseTau += tauPlusSingle
            }
        }
        
    }
    private func color(red: Int, green: Int, blue: Int) -> Color {
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255

        return Color(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue)
    }
}

#Preview {
    Genuary10(increaseTau: Double.pi * 2)
}
