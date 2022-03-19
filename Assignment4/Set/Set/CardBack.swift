//
//  CardBack.swift
//  Set
//
//  Created by Dallen Corry on 3/17/22.
//

import SwiftUI

struct CardBack:Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let borderWidth:CGFloat = 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let scaleX:CGFloat = rect.maxX/3
        let scaleY:CGFloat = rect.maxY/4
        
        //white border
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: 5, height: 5))
        
        //clear the center
        p.move(to: CGPoint(x:borderWidth, y:borderWidth))
        p.addLine(to: CGPoint(x:borderWidth, y:rect.maxY-borderWidth))
        p.addLine(to: CGPoint(x:rect.maxX-borderWidth, y:rect.maxY-borderWidth))
        p.addLine(to: CGPoint(x:rect.maxX-borderWidth, y:borderWidth))
        p.closeSubpath()
        
        //add the shape
        p.move(to: center)
        p.addLine(to: CGPoint(x:center.x+scaleX, y:center.y+scaleY))
        p.addLine(to: CGPoint(x:center.x+scaleX, y:center.y-scaleY))
        p.addLine(to: CGPoint(x:center.x-scaleX, y:center.y+scaleY))
        p.addLine(to: CGPoint(x:center.x-scaleX, y:center.y-scaleY))
        p.closeSubpath()
        p.addPath(Diamond().path(in: CGRect(x: rect.midX-(25/2), y: rect.midY+15, width: 25, height: 15)))
        p.addPath(Diamond().path(in: CGRect(x: rect.midX-(25/2), y: rect.midY-(15*2), width: 25, height: 15)))


        return p
    }
}
