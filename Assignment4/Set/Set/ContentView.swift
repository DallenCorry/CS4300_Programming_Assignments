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
            shuffle
                .padding(10)
        }
    }
    var gameBody:some View {
        AspectVGrid (items: game.cards, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .scale.animation(Animation.easeIn(duration: 1)), removal: .opacity.animation(Animation.easeIn(duration: 0.5))))//I believe here is where I will needto change things so that they can go to and from the piles they need to, nut just fade in from nothing.HINT: use matchedGeometryEffect instead of .transition
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        game.chooseCard(card)
                    }
                }
        })
            .onAppear {
                //Deal Cards
            }
    }
    
    @ViewBuilder
    var discardPile: some View {
        if (game.discardPile.count > 0){
            CardView(card: game.discardPile.last!)
                .frame(width: 45, height: 65, alignment: .bottom)
        } else {
        RoundedRectangle(cornerRadius: 5)
            .cardify(isSelected: false, threeCardsSelected: false, isMatched: false)
            .frame(width: 45, height: 65, alignment: .bottom)
            .foregroundColor(.white)
       
        }
    }
    
    var drawPile: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.blue)
            CardBack()
                .foregroundColor(.white)
        }
        .cardify(isSelected: false, threeCardsSelected: false, isMatched: false)
//        RoundedRectangle(cornerRadius: 5)
        .frame(width: 45, height: 65, alignment: .bottom)
        .onTapGesture {
            withAnimation {
                game.addCards(3)
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
    var shuffle:some View {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 5)){
                game.myShuffle()
            }
        }
    }
}


 //TODO: -
 //[ ] 1.  Animate and improve Set
 //[ ] 2.  Don't replace matched cards, discard them (leave fewer cards in the game)
        //[X] 3.  Add Deck and Discard piles
        //[X] 4.  Deck has all the not-yet-delt cards face down
        //[X] 5.  Discard pile should have all discarded cards (ie, matched cards) Face up
 //[ ] 6.  Animate the cards into the discard pile
        //[X] 7.  Tapping the deck should deal the 3 cards
//[ ] 8.  Animate dealing the cards
//[ ] 9.  Dealing 3 more cards when a match is on the board should replace those cards. (3 fly to board and 3 fly to discard at same time)
        //[X] 10. Cards should resize/change position, and be animated while doing so.
        //[X] 11. Animate when a match occurs
        //[X] 12. Animate when a Mismatch occurs (must be different than a match)
 

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
        let game = SetGame()
        ContentView(game: game)
.previewInterfaceOrientation(.portrait)
    }
}
