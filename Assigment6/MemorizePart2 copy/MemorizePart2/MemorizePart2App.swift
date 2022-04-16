//
//  MemorizePart2App.swift
//  MemorizePart2App
//
//  Created by Dallen Corry on 1/28/22.
//

import SwiftUI

@main
struct MemorizePart2App: App {
    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
                .environmentObject(themeStore)
        }
    }
}
