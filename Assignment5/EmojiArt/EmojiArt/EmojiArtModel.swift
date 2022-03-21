//
//  EmojiArtModel.swift
//  EmojiArt
//
//  CS 4300 Demo Code
//  Created by Dallen Corry on 3/11/22.
//

import Foundation

struct EmojiArtModel {
    var background = Background.blank
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Hashable { //hashable because you may need to put it in a set for Homework
        let text:String
        var x: Int //offset from the center, ie, -x is left of the center
        var y: Int //offset from the center. Useful to make it universal
        var size: Int
        let id: Int
        //note, the coordinates do have the center of the screen at 0,0. However, the top of the screen would be (0,-100), not (0,100) as in a cartesian plane. The Y still increases as you move down the screen, and the X still increases as you move right on the screen
        
        //prevent inappropriate access of the emoji
        fileprivate init(text:String, x:Int, y: Int, size:Int, id:Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    init() { }
    
    private var uniqueEmojiId = 0
    mutating func addEmoji(_ text:String, at location:(x:Int,y: Int), size:Int) {
        //location:(x:,y:) is a tuple, just a baby struct. It is how we will give our location
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id:uniqueEmojiId))
    }
}
