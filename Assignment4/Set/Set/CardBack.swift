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
        for _ in 0..<Int.random(in: 12...25) {
            let width = Int.random(in: 6...15)
            let height = Int.random(in: 5...7)
            p.addEllipse(in: CGRect(x: Int.random(in: 0...Int(rect.maxX)-(width+2)), y: Int.random(in: 0...Int(rect.maxY)-(height+2)), width: width, height: height))
        }
        return p
    }
}
