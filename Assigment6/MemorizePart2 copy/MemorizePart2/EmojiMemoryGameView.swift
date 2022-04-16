//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            header
            ZStack {
                gameBody
                deckBody
            }
            .foregroundColor(game.color)
            footer
        }
        .padding(.horizontal)
    }
    
    //MARK: - Dealing
    @State private var dealt = Set<Int>()
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }

    //MARK: Views
    var header: some View {
        ZStack {
            RoundedRectangle(cornerRadius:5)
                .fill().foregroundColor(.black)
                .frame(height: 50.0)
            HStack{
                Text(game.theme.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(5)
                Spacer()
                Text("Points: " + String(game.points))
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(5)
            }
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp{
                Color.clear
                    .animation(Animation.easeOut)
            }else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        })
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) {
                card in CardView(card:card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(game.color)
        .onTapGesture {
            for card in game.cards {
                withAnimation {
                    deal(card)
                }
            }
        }
    }
    
    var footer: some View {
        HStack {
            Button ("Shuffle"){
                withAnimation(.easeInOut) {
                    game.shuffle()
                }
             }
            Spacer()
            newGameButton
        }
    }
    
    var newGameButton: some View {
        Button {
            withAnimation {
                dealt = []
                game.newGame()
            }
        } label: {
            Text("New Game")
                .padding(5)
                .border(.blue, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio:CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration:Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight*aspectRatio
    }
        
}

//MARK: CardView
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1))
                    .padding(5)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height)/(DrawingConstants.fontSize/DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 20
    }
}


//MARK: TODO
//[ ] 1.  No random theme
//[ ] 2.  Changing theme restarts game
//[ ] 3.  Show a theme chooser on launch
//[ ] 4.  Use a List for themes
//[ ] 5.  Each row of List shows name of theme, color of theme, # of cards in theme, and some emojis of the theme
//[ ] 6.  Tapping on theme in the List Navigates to playing a game with that theme.
//[ ] 7.  Name of theme should be on screen while playing, keep same as score, new game, etc.
//[ ] 8.  From Chooser back to game should keep same game going. (not restart)
//[ ] 9.  UI to Add new Theme to the List in Chooser
//[ ] 10. Chooser must have Edit mode. Tapping brings up editor, instead of playing game with theme
//[ ] 11. Use a Form
//[ ] 12. User edit name, emojis, number of cards and color in theme
//[ ] 13. PERSISTANT Themes
//[ ] 14. Work on both Iphone and Ipad
//[ ] 15. Work on a physical device




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
