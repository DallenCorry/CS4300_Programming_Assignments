//
//  Squiggle.swift
//  Set
//
//  Created by Dallen Corry on 3/4/22.
//


import SwiftUI

struct Squiggle: Shape {
   
    
    func path(in rect: CGRect) -> Path {

        let sizeX = rect.size.width/4
        let sizeY = rect.size.height/4
        
        let x1 = rect.size.width/4
        let x2 = rect.size.width/2
        let y1 = rect.size.height/4
        let y2 = rect.size.height/2

        var center:CGPoint = CGPoint(x: rect.midX, y:rect.midY-sizeY)
        var radius:CGFloat = 10

        var p = Path()
        p.move(to: center)
        center.x += 3
        radius = 7
        p.addArc(center: center, radius: radius, startAngle: Angle.degrees(30), endAngle: Angle.degrees(120), clockwise: false)
//        p.addArc(center: center, radius: 10, startAngle: Angle.degrees(0), endAngle: Angle.degrees(80), clockwise: false)
        p.closeSubpath()

        return p
    }
}
