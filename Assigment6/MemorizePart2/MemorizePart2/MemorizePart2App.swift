//
//  MemorizePart2App.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI

@main
struct MemorizePart2App: App {
    private let game = EmojiMemoryGame()//can be a let because game is just a pointer (class is reference type)
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
