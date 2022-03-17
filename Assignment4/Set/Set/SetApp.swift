//
//  SetApp.swift
//  Set
//
//  Created by Dallen Corry on 2/14/22.
//
import SwiftUI

@main
struct SetApp: App {
    private let game = SetGame()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
