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
            gameBody
            Spacer ()
            HStack{
                drawPile
                Spacer()
                discardPile
           }
            .padding(.horizontal)
            newGame
                .padding(10)
        }
    }
    var gameBody:some View {
        
        AspectVGrid (items: game.cards, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    withAnimation(Animation.easeInOut) {//(duration: 1.5)
                        game.chooseCard(card)
                    }
                }
        })
    }
    
    var discardPile: some View {
        RoundedRectangle(cornerRadius: 10)
            .cardify(isSelected: false, threeCardsSelected: false, isMatched: false)
            .frame(width: 45, height: 65, alignment: .bottom)
    }
    
    var drawPile: some View {
        RoundedRectangle(cornerRadius: 10).frame(width: 45, height: 65, alignment: .bottom)
            .foregroundColor(.blue)
            .onTapGesture {
                withAnimation{
                    game.addCards()
                }
            }
    }
    
    var newGame:some View {
        Button("New Game") {
            withAnimation{
                game.newGame()
            }
        }
    }
}


 //TODO: -
 //[ ] 1.  Animate and improve Set
 //[ ] 2.  Don't replace matched cards, discard them (leave fewer cards in the game)
 //[ ] 3.  Add Deck and Discard piles
 //[ ] 4.  Deck has all the not-yet-delt cards face down
 //[ ] 5.  Discard pile should have all discarded cards (ie, matched cards) Face up
 //[ ] 6.  Animate the cards into the discard pile
        //[X] 7.  Tapping the deck should deal the 3 cards
//[ ] 8.  Animate dealing the cards
//[ ] 9.  Dealing 3 more cards when a match is on the board should replace those cards. (3 fly to board and 3 fly to discard at same time)
//[ ] 10. Cards should resize/change position, and be animated while doing so.
//[ ] 11. Animate when a match occurs
//[ ] 12. Animate when a Mismatch occurs (must be different than a match)
 

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
        let game = SetGame()
        ContentView(game: game)
    }
}
