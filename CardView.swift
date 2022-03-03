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
            let shape = RoundedRectangle(cornerRadius: 5)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 3)
            //body of the card
            getTheCardsBody(of: card)
        }
        .foregroundColor(.blue)//card.color?? Selected??
    }
    
    func getTheCardsBody (of card:GameModel.Card) -> some View {
        var shapeArray: [AnyView] = [AnyView]()
        let amountOfShapes = getNumber(card: card)
        switch card.shape{
        case GameModel.myShape.Diamond:
            let diamond = Diamond()
            diamond.aspectRatio(2, contentMode: .fit)

            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(Diamond()
                    //getShading(card: card)==0.9 ? diamond.stroke(getColor(card: card)) : Diamond()
//                        .stroke(getShading(card: card)==0.9 ? getColor(card: card) : .brown)
//                        .foregroundColor(getColor(card: card))
                        .aspectRatio(2, contentMode: .fit)
                    
                ))
            }
        case GameModel.myShape.Rectangle:
            for _ in 0..<amountOfShapes {
                shapeArray.append(AnyView(RoundedRectangle(cornerRadius: 5).aspectRatio(2, contentMode: .fit)))
            }
        case GameModel.myShape.Oval:
            for _ in 0..<amountOfShapes { shapeArray.append(AnyView(Ellipse().aspectRatio(2, contentMode: .fit)))
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
        .opacity(getShading(card: card))
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
        case GameModel.Shading.Open: return 0.9
        case GameModel.Shading.Stripes: return 0.45
        case GameModel.Shading.Solid: return 1.0
        }
    }
    
    
    
    
    
    
//    var body: some View {
//        GeometryReader(content: { geometry in
//            ZStack{
//                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
//                if card.isFaceUp {
//                    shape.fill().foregroundColor(.white)
//                    shape.stroke(lineWidth: DrawingConstants.lineWidth)
//                    Text(card.content).font(font(in: geometry.size))
//                } else if card.isMatched {
//                    //WILL NEED TO REMOVE 3 CARDS AND ADD 3 NEW ONES
//                    shape.opacity(0)
//                }
//                else {
//                    shape.fill()
//                }
//            }
//        })
////
//    }
//    private func font(in size: CGSize) -> Font {
//        .system(size: min(size.width, size.height)*DrawingConstants.fontScale)
//    }
//
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
