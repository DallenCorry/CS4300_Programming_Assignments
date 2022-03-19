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
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
    
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if(isFaceUp){
                //put content in the card
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
            } else {
                //leave the card blank with a custom back
                shape.foregroundColor(.blue)
                CardBack()
                    .foregroundColor(.white)
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 5
    }
    
}

extension View {
    func cardify(isSelected:Bool, threeCardsSelected:Bool, isMatched:Bool, isFaceUp:Bool) -> some View {
        return self.modifier(Cardify(isSelected: isSelected, threeCardsSelected: threeCardsSelected, isMatched: isMatched, isFaceUp: isFaceUp))
    }
}
