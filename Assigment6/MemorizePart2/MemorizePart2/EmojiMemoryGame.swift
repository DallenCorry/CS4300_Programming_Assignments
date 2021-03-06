//  View Model
//  EmojiMemoryGame.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI//because the viewModel is part of the UI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let vehicleEmojis: [String] = ["ð","ð","ð","ð","ð","ð","ð","ðŧ","ð","ð","ð","ð","ð","ð ","âïļ","ð","ð","ðĪ","âĩïļ","ðģ","ðĒ","ðī","ðĩ","ð"]
    private static let animalEmojis: [String] = ["ðķ","ðĶ","ð­","ðĶ","ðĶ","ðĒ","ðŋ"]    //,"ðĶ","ð","ðĶ","ðļ","ðĶĒ","ð","ðī","ðĶ"]
    private static let flagEmojis: [String] = ["ðĻðĶ","ðšðļ","ðŠðļ","ðēð―","ðŪðŠ","ðŊðē","ðŪðą","ðŊðĩ"] //,"ðĐðŠ","ðŦðŪ","ðīââ ïļ","ðģïļâð","ðļðŧ","ðŪðē","ðąðš"]
    private static let foodEmojis: [String] = ["ð","ð","ð","ð","ð","ðĨ"]           //,"ð","ðŦ","ð","ð","ð","ð","ðĨ­","ðĨĨ"]
    private static let faceEmojis: [String] = ["ð","ð","ð","ð","ð","ð","ð","ðĒ"] //,"ð­","ðĢ","ðĄ","ðĪŽ","ðĨĩ"]
    private static let objectEmojis: [String] = ["ð","âïļ","ð","ðš","â°","ðĄ","ðĨ"]    //,"ðĶ","ð°","ð","ðŊ","ð§","ðĻ","ð§ē","ðŽ","ðĄ"]
    
    
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
