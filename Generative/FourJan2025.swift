//
//  ContentView.swift
//  Generative
//
//  Created by Roel van der Kraan on 04/01/2025.
//

import SwiftUI

struct FourJan2025: View {
    // https://swiftwithmajid.com/2023/04/11/mastering-canvas-in-swiftui/
    

    var body: some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false)
        { context, size in
            let scaleX = 0.1
            let scaleY = 0.1
            let startX = 0.0
            let startY = -size.width / 2
            let diffX = 10.0
            let diffY = 1.0
            let numScales = 50
           
            
            context.opacity = 0.5
            for loopCount in(1..<numScales) {
                let x = startX + Double(loopCount) * diffX / 2
                let y = startY + Double(loopCount) * diffY / 2
                let scale = scaleX * Double(loopCount)
                let rect = CGRect(origin: CGPoint(x: x, y: y), size: size).applying(.init(scaleX: scale, y: scale))
                let path = Circle().path(in: rect)
                context.fill(path, with: .color(.red))
            }
            
            context.opacity = 0.2
            for loopCount in(1..<numScales) {
                let x = startX + Double(loopCount) * diffX / 2
                let y = startY + Double(loopCount) * diffY / 2
                let scale = scaleX * Double(loopCount)
                let rect = CGRect(origin: CGPoint(x: x, y: y), size: size).applying(.init(scaleX: scale, y: scale))
                let path = Circle().path(in: rect)
                context.fill(path, with: .color(.black))
            }
            
            context.opacity = 0.04
            for loopCount in(1..<numScales) {
                let x = startX + Double(loopCount) * diffX
                let y = startY + Double(loopCount) * diffY
                let scale = scaleX * Double(loopCount)
                let rect = CGRect(origin: CGPoint(x: x, y: y), size: size).applying(.init(scaleX: scale, y: scale))
                let path = Circle().path(in: rect)
                context.fill(path, with: .color(.black))
            }
            
            context.opacity = 0.5
            for loopCount in(1..<numScales) {
                let x = startX + Double(loopCount) * diffX / 2
                let y = startY + Double(loopCount) * diffY / 2
                let scale = scaleX * Double(loopCount)
                let rect = CGRect(origin: CGPoint(x: x, y: y), size: size).applying(.init(scaleX: scale, y: scale))
                let path = Circle().path(in: rect)
                context.stroke(path, with: .color(.black), lineWidth: 2.0)
            }
        }
    }
}

#Preview {
    FourJan2025()
}
