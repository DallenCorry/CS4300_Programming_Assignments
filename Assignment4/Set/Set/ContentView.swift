//  ContentView.swift
//  Set
//
//  This is the View file for the assignment 3 of CS 4300
//  Created by Dallen Corry on 2/14/22.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var game: SetGame
    
    @Namespace private var dealingNamespace
    @Namespace private var discardingNamespace
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
            }.padding(.horizontal)
            newGame
                .padding(3.0)
        }
    }

    var gameBody:some View {
        AspectVGrid (items: game.cards, aspectRatio: CardConstants.aspectRatio, content: { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                .onTapGesture {
                    withAnimation {
                        game.chooseCard(card)
                    }
                }
        })
    }
    
    @ViewBuilder
    var discardPile: some View {
        if (game.discardPile.count > 0){
            ZStack {
                ForEach(game.discardPile) {
                    card in
                    CardView(card:card)
                        .rotationEffect(Angle.degrees(card.rotation))
                        .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                        .zIndex(zIndex(of: card))
                }
            }
            .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        } else {
        RoundedRectangle(cornerRadius: CardConstants.deckCornerRadius)
            .cardify(isSelected: false, threeCardsSelected: false, isMatched: false, isFaceUp: true)
            .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
            .foregroundColor(.white)
        }
    }
    
    var drawPile: some View {
        ZStack{
            ForEach(game.undeltCards) { card in
                CardView(card:card)
                    .rotationEffect(Angle.degrees(card.rotation))//Extra Credit: Messy Deck.
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            if game.cards.count > 0{
                for i in 0..<3 {
                    withAnimation(customDealAnimation(i)) {
                        game.addCards(1)
                    }
                }
            }
        }
    }
    
    var newGame:some View {
        Button("New Game") {
            withAnimation(customDealAnimation(1)) {
                game.newGame()
            }
        }
    }
    
    private func customDealAnimation(_ i:Int) -> Animation {
        var delay = 0.0
        delay = Double(i) * (CardConstants.totalDealDuration / 3.0)
        return Animation.easeInOut(duration:0.2).delay(delay)
    }
    
    private func zIndex(of card:GameModel.Card) -> Double {
        -Double(game.undeltCards.firstIndex(where: {$0.id == card.id}) ?? 100)
    }
    
    private struct CardConstants {
        static let totalDealDuration: Double = 0.5
        static let deckCornerRadius: CGFloat = 5
        static let aspectRatio: CGFloat = 2/3
        static let deckHeight: CGFloat = 70
        static let deckWidth: CGFloat = deckHeight * aspectRatio
        static let deckColor: Color = .blue

    }
}


 //TODO: -

//clean up code

//Extra Credit
    //draw from the top
        //eh, good enough

        //[X] 1.  Animate and improve Set
        //[X] 2.  Don't replace matched cards, discard them (leave fewer cards in the game)
        //[X] 3.  Add Deck and Discard piles
        //[X] 4.  Deck has all the not-yet-delt cards face down
        //[X] 5.  Discard pile should have all discarded cards (ie, matched cards) Face up
        //[X] 6.  Animate the cards into the discard pile
        //[X] 7.  Tapping the deck should deal the 3 cards
        //[X] 8.  Animate dealing the cards
        //[X] 9.  Dealing 3 more cards when a match is on the board should replace those cards. (3 fly to board and 3 fly to discard at same time)
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
