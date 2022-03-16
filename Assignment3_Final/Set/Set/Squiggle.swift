//
//  Squiggle.swift
//  Set
//
//  Created by Dallen Corry on 3/4/22.
//  Path created and edited by Dallen Corry using PaintCode
//  EXTRA Credit

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let myScale:CGFloat = rect.maxX/50
        let start = CGPoint(x: rect.minX, y: myScale*10)

        var p = Path()
        p.move(to: start)
        p.addCurve(to: CGPoint(x: myScale*4.15, y: myScale*3.16), control1: CGPoint(x: myScale*1.35, y: myScale*7.69), control2: CGPoint(x: myScale*1.15, y: myScale*5.66))
        p.addCurve(to: CGPoint(x: myScale*13.41, y: myScale*0.63), control1: CGPoint(x: myScale*7.15, y: myScale*0.66), control2: CGPoint(x: myScale*7.91, y: myScale*(-0.12)))
        p.addCurve(to: CGPoint(x: myScale*26.42, y: myScale*7.87), control1: CGPoint(x: myScale*18.91, y: myScale*1.38), control2: CGPoint(x: myScale*20.67, y: myScale*6.62))
        p.addCurve(to: CGPoint(x: myScale*37.03, y: myScale*3.41), control1: CGPoint(x: myScale*32.17, y: myScale*9.12), control2: CGPoint(x: myScale*33.28, y: myScale*2.91))
        p.addCurve(to: CGPoint(x: myScale*41.1, y: myScale*11.54), control1: CGPoint(x: myScale*40.78, y: myScale*3.91), control2: CGPoint(x: myScale*42.32, y: myScale*6.6))
        p.addCurve(to: CGPoint(x: myScale*36.29, y: myScale*19.39), control1: CGPoint(x: myScale*41.1, y: myScale*11.54), control2: CGPoint(x: myScale*40.04, y: myScale*16.64))
        p.addCurve(to: CGPoint(x: myScale*27.23, y: myScale*22.09), control1: CGPoint(x: myScale*32.54, y: myScale*22.14), control2: CGPoint(x: myScale*32.73, y: myScale*22.84))
        p.addCurve(to: CGPoint(x: myScale*12.65, y: myScale*15.48), control1: CGPoint(x: myScale*21.73, y: myScale*21.34), control2: CGPoint(x: myScale*18.15, y: myScale*16.48))
        p.addCurve(to: CGPoint(x: myScale*3.65, y: myScale*18.48), control1: CGPoint(x: myScale*7.15, y: myScale*14.48), control2: CGPoint(x: myScale*6.9, y: myScale*19.48))
        p.addCurve(to: CGPoint(x: myScale*0, y: myScale*10.69), control1: CGPoint(x: myScale*0.4, y: myScale*17.48), control2: CGPoint(x: myScale*(-0.65), y: myScale*13.69))

        p.closeSubpath()

        return p
    }
}
