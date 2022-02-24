//  ContentView.swift
//  Set
//
//  This is the View file for the assignment 3 of CS 4300
//  Created by Dallen Corry on 2/14/22.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var game: SetGame
    var body: some View {
        VStack {
            Text ("SET")
            AspectVGrid (items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
//                        game.choose(card)
                        print(card.content, card.number, card.color, card.shape, card.shading)
                    }
            })
//                .foregroundColor(.purple)
            Spacer ()
            HStack{
                Text("Draw 3 Cards")
                    .onTapGesture {
                        print("That tickles!")
                    }
                let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill(Color.red)
                    .frame(width: 60, height: 90)
                    .onTapGesture {
                        print("That tickles!")
                    }
            }
//            Spacer()
            Button("New Game"){
                print("I work")
            }
        }
    }
}


struct CardView: View {//<SomeShape: Shape>
    let card: GameModel.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 5)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 3)
            
            HStack {
                //for loop here putting in several shapes?? using the card.shape??
                getTheCardsBody(for: card)
//                Diamond(startingPosition: CGPoint(x:30,y:40), size: 10)
//                    .foregroundColor(getColor(card: card))
//                    .opacity(getShading(card: card))
            }

            //here is where I will need to change from a text to my shape, I think.
            //but it probably should still be card.content, or something similar. Just not Text().

                
        }
        .foregroundColor(Color.blue)//card.color?? Selected??
    }
    
    func getTheCardsBody (for card:GameModel.Card) -> some View {
        var shapeArray: [AnyView] = [AnyView]()
        for i in 0..<getNumber(card: card) {
            shapeArray.append(AnyView(Diamond(startingPosition: CGPoint(x:(10*(i+1)),y:40), size: 10)))
        }
        return VStack {
            shapeArray[0]
            Text(String(shapeArray.count))
            
        }
        .foregroundColor(getColor(card: card))
    }
    
    func getColor(card: GameModel.Card) -> Color {
        switch card.color {
        case GameModel.myColor.Green: return .green
        case GameModel.myColor.Purple : return .purple
        case GameModel.myColor.Orange : return .orange
//        default: return .green
        }
    }
    func getNumber(card: GameModel.Card) -> Int {
        switch card.number {
        case GameModel.Number.One: return 1
        case GameModel.Number.Two : return 2
        case GameModel.Number.Three : return 3
        }
    }
//    func getShape(card: GameModel.Card) -> some View {
//        switch card.shape {
//        case GameModel.myShape.Rectangle: return RoundedRectangle(cornerRadius: 1)
//        case GameModel.myShape.Diamond : return Diamond(startingPosition: CGPoint(x:30,y:40), size: 10)
//        case GameModel.myShape.Oval : return Circle()
//        }
//    }
    func getShading(card: GameModel.Card) -> Double {
        switch card.shading {
        case GameModel.Shading.Open: return 0.1
        case GameModel.Shading.Stripes: return 0.3
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
//    private struct DrawingConstants {
//        static let cornerRadius: CGFloat = 10
//        static let lineWidth: CGFloat = 3
//        static let fontScale: CGFloat = 0.8
//    }
}













//TODO:
//[ ] 1. Make Set
//[ ] 2. Keep all shapes good size
//[ ] 3. Same aspect ratio throughout
//[ ] 4. Symbols should be proportional to card
//[ ] 5. Select 3 cards, Must be visible and obvious which one. (change color of border?)
//[ ] 6. Indicate if match or not. Cards must look different than just normal, and than just selected
//[ ] 7. Support "deselection" (only if 1 or 2 cards selected
//[ ] 8. On a match: replace 3 cards with 3 new ones. adjust view when there are no more cards to draw,
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        ContentView(game: game)
    }
}
