//
//  Theme.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 2/7/22.
//

import Foundation

struct Theme {
    var name: String
    var emojiArray: [String]
    var numberOfPairs: Int
    var color: String
    
    init (name: String, emojiArray: [String], numberOfPairs: Int, color:String){
        self.name = name
        self.emojiArray = emojiArray
        self.numberOfPairs = numberOfPairs
        self.color = color
    }
}



