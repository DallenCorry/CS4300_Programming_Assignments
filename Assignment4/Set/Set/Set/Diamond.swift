//
//  Diamond.swift
//  Set
//
//  Created by Dallen Corry on 2/23/22.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let sizeX = rect.size.width/4
        let sizeY = rect.size.height/4

        let center = CGPoint(x: rect.midX, y:rect.midY-sizeY)

        var p = Path()
        p.move(to: center)
        p.addLine(to: CGPoint(
            x:center.x-sizeX*2,
            y:center.y+sizeY))
        p.addLine(to: CGPoint(
            x:center.x,
            y:center.y+(sizeY*2)))
        p.addLine(to: CGPoint(
            x:center.x+sizeX*2,
            y:center.y+(sizeY)))
        p.closeSubpath()

        return p
    }
}
