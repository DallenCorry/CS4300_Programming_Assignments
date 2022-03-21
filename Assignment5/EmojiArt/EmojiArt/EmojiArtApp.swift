//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Dallen Corry on 3/11/22.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    //can pass multiple eventually
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
