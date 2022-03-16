//
//  CardView.swift
//  Set
//
//  Created by Dallen Corry on 2/25/22.
//

import SwiftUI

struct CardView: View {
    let card: GameModel.Card
    var body: some View {
        ZStack {
            //Card
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.fill().foregroundColor(.white)
            if(card.isSelected){
                if card.threeCardsSelected {
                    if card.isMatched {
                        shape.stroke(.green, lineWidth: DrawingConstants.lineWidth)
                    } else {
                        shape.stroke(.red, lineWidth: DrawingConstants.lineWidth)
                    }
                } else {
                    shape.stroke(.yellow, lineWidth: DrawingConstants.lineWidth)
                }
            }else {
                shape.stroke(.blue, lineWidth: DrawingConstants.lineWidth)
            }
            //body of the card
            getTheCardsBody(of: card)
        }
    }
    
    func getTheCardsBody (of card:GameModel.Card) -> some View {
        var shapeArray: [AnyView] = [AnyView]()
        let amountOfShapes = getNumber(card: card)
        switch card.shape{
        case GameModel.myShape.Diamond:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(
                    Diamond()
                        .aspectRatio(2, contentMode: .fit)
                        .opacity(getShading(card: card))
                        .overlay(Diamond().stroke(getColor(card: card), lineWidth: DrawingConstants.lineWidth).frame(width: nil, height: nil))
                ))
            }
        case GameModel.myShape.Squiggle:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(
                    Squiggle()//EXTRA CREDIT
                        .aspectRatio(2, contentMode: .fit)
                        .opacity(getShading(card: card))
                        .overlay(
                            Squiggle().stroke(getColor(card: card), lineWidth: DrawingConstants.lineWidth).frame(width: nil, height: nil))
                ))
                        
            }
        case GameModel.myShape.Oval:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(
                    Ellipse()
                        .aspectRatio(2, contentMode: .fit)
                        .opacity(getShading(card: card))
                        .overlay(Ellipse().stroke(getColor(card: card), lineWidth: DrawingConstants.lineWidth))
                ))
            }
        }
        return VStack{
            //struct has a view and id, then can use foreach
            if shapeArray.count > 0 {
                shapeArray[0]
            }
            if shapeArray.count > 1 {
                shapeArray[1]
            }
            if shapeArray.count > 2 {
                shapeArray[2]
            }
        }
        .padding(10)
        .foregroundColor(getColor(card: card))
    }
    
    func getColor(card: GameModel.Card) -> Color {
        switch card.color {
        case GameModel.myColor.Green: return .green
        case GameModel.myColor.Purple : return .purple
        case GameModel.myColor.Orange : return .orange
        }
    }
    func getNumber(card: GameModel.Card) -> Int {
        switch card.number {
        case GameModel.Number.One: return 1
        case GameModel.Number.Two : return 2
        case GameModel.Number.Three : return 3
        }
    }
    func getShading(card: GameModel.Card) -> Double {
        switch card.shading {
        case GameModel.Shading.Open: return 0.01
        case GameModel.Shading.Stripes: return 0.45
        case GameModel.Shading.Solid: return 1.0
        }
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
