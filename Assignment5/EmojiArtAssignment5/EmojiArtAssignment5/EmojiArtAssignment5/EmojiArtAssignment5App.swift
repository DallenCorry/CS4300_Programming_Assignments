//
//  EmojiArtAssignment5App.swift
//  EmojiArtAssignment5
//
//  Created by Dallen Corry on 3/28/22.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}

