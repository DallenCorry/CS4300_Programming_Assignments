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
            getTheCardBody(of: card)
                .scaleEffect( CGSize(width: 1, height: !card.isMatched&&card.threeCardsSelected ?0.55: 1))
                .cardify(isSelected: card.isSelected, threeCardsSelected: card.threeCardsSelected, isMatched: card.isMatched, isFaceUp: card.isFaceUp)
                .rotationEffect(Angle.degrees(card.isMatched&&card.threeCardsSelected ? 360: 0))
    }
    
    func getTheCardBody (of card:GameModel.Card) -> some View {
        var shapeArray: [AnyView] = [AnyView]()
        let amountOfShapes = getNumber(card: card)
        switch card.shape{
        case GameModel.myShape.Diamond:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(
                    Diamond()
                        .aspectRatio(2, contentMode: .fit)
                        .opacity(getShading(card: card))
                        .overlay(Diamond().stroke(getColor(card: card), lineWidth: DrawingConstants.lineWidth))
                ))
            }
        case GameModel.myShape.Squiggle:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(
                    Squiggle()//EXTRA CREDIT
                        .aspectRatio(2, contentMode: .fit)
                        .opacity(getShading(card: card))
                        .overlay(Squiggle().stroke(getColor(card: card), lineWidth: DrawingConstants.lineWidth))
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
        static let fontScale: CGFloat = 0.8
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 4
    }
}
