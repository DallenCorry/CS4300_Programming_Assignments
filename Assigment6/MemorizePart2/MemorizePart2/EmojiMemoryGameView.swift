//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ZStack {
            //top bar
//            RoundedRectangle(cornerRadius:5)
//                .fill().foregroundColor(.black)
//                .frame(height: 50.0)
//            HStack{
//                Text(game.theme.name)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(5)
//                Spacer()
//                Text("Points: " + String(game.points))
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .padding(5)
//            }
        //main body
        VStack {
            gameBody
            .foregroundColor(game.color)
            //bottom buttons
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
        deckBody
    }
        .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) {
                card in CardView(card:card)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
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
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        //the user's intent
                        withAnimation(.easeInOut) {
                            game.choose(card)
                        }
                    }
            }
        })
    }
    
    var newGameButton: some View {
        Button {
            //do new game things here
            game.newGame()
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

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 120-90))
                        .padding(5)
                        .opacity(0.5)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.easeInOut(duration: 1))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
                }
                .modifier(Cardify(isFaceUp: card.isFaceUp))
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


//TODO: -
//add a theme.
//Themes have a name, a set of emojis, a number of pairs of cards, and a color for the cards
    //enums will be important
    //need at least 6 themes
    //maybe make another file/thing that is a Theme (this is what I would do, if it were OOP. Just make a new class. So can I make a new struct? (if so probs make a new file)
//Add a new Theme with a single line of code ( a constructor could do that...)
        // 1. [X] get it working
        // 2. [X] Remove other buttons
        // 3. [X] Make Themes
        // 4. [X] Make 1 theme with fewer pairs
        // 5. [X] use a random part of the emojis
        // 6. [X] allow no duplicate pairs
// 7. [?] automatically set number of cards lower if there aren't enough emojis.
        // 8. [X] at least 6 themes
        // 9. [X] add themes with a single line of code
        //10. [X] add New Game button
        //11. [X] randomly choose theme when creating new game
        //12. [X] start with cards all Face Down
        //13. [X] Cards should be shuffled
        //14. [X] Display the Theme's name
        //15. [X] Keep Score in the game
        //16. [X] Display the score



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
    }
}
