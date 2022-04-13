//  View Model
//  EmojiMemoryGame.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI//because the viewModel is part of the UI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let vehicleEmojis: [String] = ["🚗","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚛","🚜","🚃","🚝","🚄","🚠","✈️","🚁","🚀","🚤","⛵️","🛳","🚢","🛴","🛵","🏍"]
    private static let animalEmojis: [String] = ["🐶","🦁","🐭","🦄","🦕","🐢","🐿"]    //,"🦆","🐍","🦅","🐸","🦢","🐙","🐴","🦉"]
    private static let flagEmojis: [String] = ["🇨🇦","🇺🇸","🇪🇸","🇲🇽","🇮🇪","🇯🇲","🇮🇱","🇯🇵"] //,"🇩🇪","🇫🇮","🏴‍☠️","🏳️‍🌈","🇸🇻","🇮🇲","🇱🇺"]
    private static let foodEmojis: [String] = ["🍎","🍐","🍊","🍓","🍇","🥝"]           //,"🍍","🫐","🍒","🍋","🍌","🍉","🥭","🥥"]
    private static let faceEmojis: [String] = ["😀","😍","😂","😇","🙃","😋","😕","😢"] //,"😭","😣","😡","🤬","🥵"]
    private static let objectEmojis: [String] = ["📞","☎️","📟","📺","⏰","💡","🎥"]    //,"🔦","💰","💎","🕯","🔧","🔨","🧲","🔬","🗡"]
    
    
    private static var themesArray: Array<Theme> = [
        Theme(name: "Vehicles", emojiArray: vehicleEmojis, numberOfPairs: 7, color: "Red"),
        Theme(name: "Animals", emojiArray: animalEmojis, numberOfPairs: animalEmojis.count, color: "Orange"),
        Theme(name: "Flags", emojiArray: flagEmojis, numberOfPairs: flagEmojis.count, color: "Yellow"),
        Theme(name: "Food", emojiArray: foodEmojis, numberOfPairs: foodEmojis.count, color: "Green"),
        Theme(name: "Faces", emojiArray: faceEmojis, numberOfPairs: faceEmojis.count, color: "Blue"),
        Theme(name: "Objects", emojiArray: objectEmojis, numberOfPairs: 6, color: "Purple")
    ]
    
    @Published var theme: Theme
    @Published private var model: MemoryGame<String>
    
    init() {
        let localTheme = Self.themesArray.randomElement()!
        theme = localTheme
        model = Self.createMemoryGame(localTheme)
//        model.cards.shuffle()
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var points: Int {
        model.points
    }
    
    var color: Color {
        switch theme.color {
        case "Red": return .red
        case "Orange" : return .orange
        case "Yellow": return .yellow
        case "Green" : return .green
        case "Blue": return .blue
        case "Purple" : return .purple
        default: return .indigo
        }
    }
    
//    var currentEmoji: Array<String> {
//        return game.cards.shuffled()
//
//    }
   
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) {
            pairIndex in theme.emojiArray[pairIndex]//this is just the second argument of the init.
        }
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
        if model.allAreMatched() {
            print("You Win!")
        }
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themesArray.randomElement()!
        theme.emojiArray = theme.emojiArray.shuffled()
        model = Self.createMemoryGame(theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
