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
                .font(.title)
//            ScrollView {
                AspectVGrid (items: game.cards, aspectRatio: 2/3, content: { card in
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.chooseCard(card)
                        }
                })
//            }
            Spacer ()
            HStack{
                Text("Draw 3 Cards")
                    .font(.title)
                    
//                Image(systemName: "plus.rectangle.portrait")
//                    .font(.largeTitle)
                RoundedRectangle(cornerRadius: 10).frame(width: 40, height: 60, alignment: .bottom)
                    .foregroundColor(.blue)
            }
            .onTapGesture {
//                print("That tickles!", game.model.numberOfCardsOnScreen)
                game.addCards(3)
            }
            Button("New Game"){
                print("I work")
            }
            .padding(10)
           
           
        }
    }
}


//TODO: -
//[ ] 1. Make solo Set
        //[X] 2. Keep all shapes good size
        //[X] 3. Same aspect ratio throughout
        //[X] 4. Symbols should be proportional to card
        //[X] 5. Select 3 cards, Must be visible and obvious which one. (change color of border?)
//[ ] 6. Indicate if match or not. Cards must look different than just normal, and different than just selected
        //[X] 7. Support "deselection" (only if 1 or 2 cards selected)
//[ ] 8. a) On a match: replace 3 cards with 3 new ones.
//[ ] 8. b) adjust view when there are no more cards to draw
//[ ] 8. c) if tapped card not part of set, select it
//[ ] 8. d) if tapped card was part of set, do nothing (don't deselect the good set, and don't select anything else)
        //[X] 9. if the 3 cards are not a match, deselect the other 3 and select the 4th (even if it was one of the 3)
//[ ] 10. a) deal 3 button must replace a set of 3 if possible
//[ ] 10. b) deal 3 button must add 3 new cards if 0,1,2, or 3 cards selected (if no set) and NOT affect the selection
//[ ] 10. c) deal 3 button must be disabled if no more cards.
//[ ] 11. New game button starts a new game
        //[X] 12. Squiggle can be a rectangle
        //[X] 13. make own Diamond struct
        //[X] 14. use shading instead of stripes
        //[X] 15. use any 3 colors
        //[X] 16. must use enum
//[ ] 17. must use a closure
//[ ] 18. should work in portrait and landscape


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        ContentView(game: game)
    }
}
