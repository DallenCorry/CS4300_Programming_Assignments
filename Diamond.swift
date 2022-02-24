//
//  Diamond.swift
//  Set
//
//  Created by Dallen Corry on 2/23/22.
//

import SwiftUI

struct Diamond: Shape {
    var startingPosition: CGPoint
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
//        let center = CGPoint(x: rect.midX, y:rect.midY)
//        let radius = min(rect.width, rect.height)/2
//        let start = CGPoint(
//            x:  center.x+radius * CGFloat(cos(starAngle.radians)),
//            y:center.x+radius * CGFloat(sin(starAngle.radians))
//        )
        var p = Path()
        p.move(to: startingPosition)
        p.addLine(to: CGPoint(
            x:startingPosition.x-size,
            y:startingPosition.y+(size*2)))
        p.addLine(to: CGPoint(
            x:startingPosition.x,
            y:startingPosition.y+(size*4)))
        p.addLine(to: CGPoint(
            x:startingPosition.x+size,
            y:startingPosition.y+(size*2)))
        p.closeSubpath()
        return p
    }
}
