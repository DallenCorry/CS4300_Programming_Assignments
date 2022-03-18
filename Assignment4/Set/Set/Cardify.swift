//
//  Cardify.swift
//  Set
//
//  Created by Dallen Corry on 3/16/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isSelected: Bool
    var threeCardsSelected: Bool
    var isMatched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

            if(isSelected){
                shape.stroke(
                    threeCardsSelected ? (
                        isMatched ? .green : .red) :
                            .yellow,
                    lineWidth:DrawingConstants.lineWidth)
            }else {
                shape.stroke(.blue, lineWidth: DrawingConstants.lineWidth)
            }
            shape.fill().foregroundColor(.white)
            content
        }
//        .rotation3DEffect(Angle.degrees(isMatched ? 0 : 180), axis: (0,1,0))//works
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 4
    }
    
}

extension View {
    func cardify(isSelected:Bool, threeCardsSelected:Bool, isMatched:Bool) -> some View {
        return self.modifier(Cardify(isSelected: isSelected, threeCardsSelected: threeCardsSelected, isMatched: isMatched))
    }
}
