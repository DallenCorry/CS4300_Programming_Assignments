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

//struct DiamondForEachable: Identifiable {
//    let id = UUID()
//    static func diamonds(with count: Int) -> [DiamondForEachable] {
//        .init(repeating: .init(), count: count)
//    }
//}















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
