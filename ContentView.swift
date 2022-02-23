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
            let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill(Color.red)
                .frame(width: 150, height: 150)
                .onTapGesture {
                    print("That tickles!")
                }
            
            Text ("Game!")
            
        }
        
    }
}


struct CardView: View {
    let card: GameModel.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 5)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 3)
            Text(card.content)
            //here is where i will need to change from a text to my shape
                .font(.footnote)
                .foregroundColor(Color.green)
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
