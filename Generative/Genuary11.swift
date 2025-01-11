//
//  Genuary11.swift
//  Generative
//
//  Created by Roel van der Kraan on 11/01/2025.
//

import SwiftUI

//https://thevirtualinstructor.com/twopointperspective.html
struct Genuary11: View {
    let horizonY = -700.0
    let vanishingPoint1 = CGPoint(x: -900, y: -700)
    let vanishingPoint2 = CGPoint(x: 1800.0, y: -700)
    
    var body: some View {
        Canvas { context, size in
            let startPoint = CGPoint(x: 800, y: size.height+1900)
            let vector = unitVector(from: startPoint, to: vanishingPoint1)
            let numOfRows = 20
            var rowDepth = 140.0
            var rowSpacing = 30.0
            for index in stride(from: numOfRows, to: 0, by: -1) {
                
                let rowOrigin = CGPoint(x: startPoint.x + vector.dx * CGFloat(index) * rowDepth, y: startPoint.y + vector.dy * CGFloat(index) * rowDepth)
                
                drawCubeRow(in: &context, size: CGSize(width: size.width + 400, height: size.height), from: rowOrigin, to: vanishingPoint2)
                            }
            
            
            
            //drawPerspectiveCube(cube2, vanashingPointLeft: vanishingPoint1, vanashingPointRight: vanishingPoint2, in: &context, contextSize: size)
        }
        .ignoresSafeArea()
    }
    
    func drawCubeRow(in context: inout GraphicsContext, size: CGSize, from: CGPoint, to: CGPoint) {
        
        let vector = unitVector(from: from, to: to)
        let numCubes = Int.random(in: 10...20)
        var cubeSize = size.width / CGFloat(numCubes-1)
        var cubeDepth = CGFloat.random(in: 40.0...90.0)
        
        for index in stride(from: numCubes, to: 0, by: -1) {
            let cubeOrigin = CGPoint(x: from.x + vector.dx * CGFloat(index) * cubeSize, y: from.y + vector.dy * CGFloat(index) * cubeSize)
            
            // Depth has to adjust as we get closer to the vanishing point
            let cube = PerspectiveCube(origin: cubeOrigin, size: CGSize(width: cubeSize-10.0, height: CGFloat.random(in: 50.0...600.0)), depth: cubeDepth, vanishingPointLeft: vanishingPoint1, vanishingPointRight: vanishingPoint2)
            drawPerspectiveCube(cube, in: &context)
            
            cubeDepth += 0.1
        }
        
    }
    
    func drawPerspectiveCube(_ cube: PerspectiveCube, in context: inout GraphicsContext) {
        
        context.opacity = 0.9
        drawSide(pointA: cube.frontTop, pointB: cube.frontBottom, pointC: cube.rightBottom, pointD: cube.rightTop, sideColor: .blue, in: &context)
        
        drawSide(pointA: cube.frontTop, pointB: cube.frontBottom, pointC: cube.leftBottom, pointD: cube.leftTop, sideColor: .black, in: &context)
        
        drawSide(pointA: cube.frontTop, pointB: cube.leftTop, pointC: cube.backTop, pointD: cube.rightTop, sideColor: .white, in: &context)
        
    }
    
    
    func drawSide(pointA: CGPoint, pointB: CGPoint, pointC: CGPoint, pointD: CGPoint, sideColor: Color, in context: inout GraphicsContext) {
            // Draw side face
            var sideFace = Path()
        sideFace.move(to: pointA)
        sideFace.addLine(to: pointB)
        sideFace.addLine(to: pointC)
        sideFace.addLine(to: pointD)
            sideFace.closeSubpath()
            context.fill(sideFace, with: .color(sideColor))
    }
    
    func perspectiveTransform(from pointA: CGPoint, to pointB: CGPoint, distance: CGFloat) -> CGPoint {
        let unitVector = unitVector(from: pointA, to: pointB)
        return CGPoint(x:pointA.x + unitVector.dx * distance, y: pointA.y + unitVector.dy * distance)
    }
    
    func unitVector(from pointA: CGPoint, to pointB: CGPoint) -> CGVector {
        let xDiff = pointB.x - pointA.x
        let yDiff = pointB.y - pointA.y
        let distance = sqrt(pow(xDiff, 2) + pow(yDiff, 2))
        return CGVector(dx: xDiff/distance, dy: yDiff/distance)
    }
    
    func linesCross(start1: CGPoint, end1: CGPoint, start2: CGPoint, end2: CGPoint) -> CGPoint? {
        // calculate the differences between the start and end X/Y positions for each of our points
        let delta1x = end1.x - start1.x
        let delta1y = end1.y - start1.y
        let delta2x = end2.x - start2.x
        let delta2y = end2.y - start2.y

        // create a 2D matrix from our vectors and calculate the determinant
        let determinant = delta1x * delta2y - delta2x * delta1y

        if abs(determinant) < 0.0001 {
            // if the determinant is effectively zero then the lines are parallel/colinear
            return nil
        }

        // if the coefficients both lie between 0 and 1 then we have an intersection
        let ab = ((start1.y - start2.y) * delta2x - (start1.x - start2.x) * delta2y) / determinant

        if ab > 0 && ab < 1 {
            let cd = ((start1.y - start2.y) * delta1x - (start1.x - start2.x) * delta1y) / determinant

            if cd > 0 && cd < 1 {
                // lines cross – figure out exactly where and return it
                let intersectX = start1.x + ab * delta1x
                let intersectY = start1.y + ab * delta1y
                return CGPoint(x: intersectX, y: intersectY)
            }
        }

        // lines don't cross
        return nil
    }
}

struct PerspectiveCube {
    var origin: CGPoint
    var size: CGSize
    var depth: CGFloat
    var vanishingPointLeft: CGPoint
    var vanishingPointRight: CGPoint
    
    var frontTop: CGPoint {
        return CGPoint(x: origin.x, y: origin.y - size.height)
    }
    
    var frontBottom: CGPoint {
        return origin
    }
    
    var leftTop: CGPoint {
        return perspectiveTransform(from: frontTop, to: vanishingPointLeft, distance: depth)
    }
    
    var rightTop: CGPoint {
        return perspectiveTransform(from: frontTop, to: vanishingPointRight, distance: size.width)
    }
    
    var leftBottom: CGPoint {
        return linesCross(start1: leftTop, end1: CGPoint(x: leftTop.x, y: 100000), start2: frontBottom, end2: vanishingPointLeft)!
    }
    
    var rightBottom: CGPoint{
        return linesCross(start1: rightTop, end1: CGPoint(x: rightTop.x, y: 100000), start2: frontBottom, end2: vanishingPointRight)!
    }
    
    var backTop: CGPoint {
        return linesCross(start1: leftTop, end1: vanishingPointRight, start2: rightTop, end2: vanishingPointLeft)!
    }
    
    func perspectiveTransform(from pointA: CGPoint, to pointB: CGPoint, distance: CGFloat) -> CGPoint {
        let unitVector = unitVector(from: pointA, to: pointB)
        return CGPoint(x:pointA.x + unitVector.dx * distance, y: pointA.y + unitVector.dy * distance)
    }
    
    func unitVector(from pointA: CGPoint, to pointB: CGPoint) -> CGVector {
        let xDiff = pointB.x - pointA.x
        let yDiff = pointB.y - pointA.y
        let distance = sqrt(pow(xDiff, 2) + pow(yDiff, 2))
        return CGVector(dx: xDiff/distance, dy: yDiff/distance)
    }
    
    func linesCross(start1: CGPoint, end1: CGPoint, start2: CGPoint, end2: CGPoint) -> CGPoint? {
        // calculate the differences between the start and end X/Y positions for each of our points
        let delta1x = end1.x - start1.x
        let delta1y = end1.y - start1.y
        let delta2x = end2.x - start2.x
        let delta2y = end2.y - start2.y
        
        // create a 2D matrix from our vectors and calculate the determinant
        let determinant = delta1x * delta2y - delta2x * delta1y
        
        if abs(determinant) < 0.0001 {
            // if the determinant is effectively zero then the lines are parallel/colinear
            return nil
        }
        
        // if the coefficients both lie between 0 and 1 then we have an intersection
        let ab = ((start1.y - start2.y) * delta2x - (start1.x - start2.x) * delta2y) / determinant
        
        if ab > 0 && ab < 1 {
            let cd = ((start1.y - start2.y) * delta1x - (start1.x - start2.x) * delta1y) / determinant
            
            if cd > 0 && cd < 1 {
                // lines cross – figure out exactly where and return it
                let intersectX = start1.x + ab * delta1x
                let intersectY = start1.y + ab * delta1y
                return CGPoint(x: intersectX, y: intersectY)
            }
        }
        
        // lines don't cross
        return nil
    }
}

#Preview {
    Genuary11()
}
