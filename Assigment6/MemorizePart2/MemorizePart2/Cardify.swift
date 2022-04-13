//
//  Cardify.swift
//  MemorizePart2
//
//  Wraps a card around a view and returns a card view
//  Created by Dallen Corry on 2/16/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
//    var isFaceUp: Bool
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    var rotation: Double // rotation in degrees
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
                
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1:0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        
        //we need to get rid of the fading opacity, and make the emoji apear at 90 and not earlier
        //to do that, we make our view modifier Cardify a animatable modifier and implement the var
        //animatableData.
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
         self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
