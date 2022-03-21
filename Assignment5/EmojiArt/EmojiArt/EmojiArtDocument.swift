//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  View Model
//  Created by Dallen Corry on 3/11/22.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    @Published private(set) var emojiArt: EmojiArtModel
    
    init() {
        emojiArt = EmojiArtModel()
        emojiArt.addEmoji("🤥", at: (x: -80, y: -40), size: 25)
        emojiArt.addEmoji("🤠", at: (x: 30, y: 40), size: 25)
    }
    
    var emojis: [EmojiArtModel.Emoji] { emojiArt.emojis }
    
    var background: EmojiArtModel.Background { emojiArt.background }
    
    
    // MARK: - Intent(s)
    
    //setBackground, addEmoji, moveEmoji, scaleEmoji
    
    func setBackground(_ background: EmojiArtModel.Background){
        emojiArt.background = background
    }
    
    func addEmoji(_ emoji: String, at location:(x:Int, y:Int),size:CGFloat) {
        emojiArt.addEmoji(emoji, at:location,size:Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset:CGSize) {
        if let index = emojiArt.emojis.index(matching:emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale:CGFloat) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrAwayFromZero))
        }
    }
}
