//
//  ThemeStore.swift
//  MemorizePart2
//
//  View Model for the chooser.
//  Created by Dallen Corry on 4/13/22.
//

import SwiftUI
//view model exposes the themes
//intets: add theme, delete thime, etc.

//The View Model object is an observed object
//@ObservedObject = someone else owns this thing, so it is created in another model?
//if it were an @StateObject, then it would be removed each time you go out of the panel, because it will be created when you tap on the button.

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojiArray: [String]
    var numberOfPairs: Int
    var color: String
    var id: Int
    
    init (name: String, emojiArray: [String], numberOfPairs: Int, color:String, id:Int){
        self.name = name
        self.emojiArray = emojiArray
        self.numberOfPairs = numberOfPairs
        self.color = color
        self.id = id
    }
}



class ThemeStore: ObservableObject {
    let name:String
    @Published var themesArray = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themesArray.isEmpty {
            insertTheme(named: "Vehicles", emojis: ["🚗","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚛","🚜","🚃","🚝","🚄","🚠","✈️","🚁","🚀","🚤","⛵️","🛳","🚢","🛴","🛵","🏍"], numberOfPairs: 7, color: "Red")
            insertTheme(named: "Animals", emojis: ["🐶","🦁","🐭","🦄","🦕","🐢","🐿","🦆","🐍","🦅","🐸","🦢","🐙","🐴","🦉"], numberOfPairs: 10, color: "Orange")
            insertTheme(named: "Flags", emojis: ["🇨🇦","🇺🇸","🇪🇸","🇲🇽","🇮🇪","🇯🇲","🇮🇱","🇯🇵","🇩🇪","🇫🇮","🏴‍☠️","🏳️‍🌈","🇸🇻","🇮🇲","🇱🇺"], numberOfPairs: 8, color: "Yellow")
            insertTheme(named: "Food", emojis: ["🍎","🍐","🍊","🍓","🍇","🥝","🍍","🫐","🍒","🍋","🍌","🍉","🥭","🥥"], numberOfPairs: 12, color: "Green")
            insertTheme(named: "Faces", emojis: ["😀","😍","😂","😇","🙃","😋","😕","😢","😭","😣","😡","🤬","🥵"], numberOfPairs: 13, color: "Blue")
            insertTheme(named: "Objects", emojis: ["📞","☎️","📟","📺","⏰","💡","🎥","🔦","💰","💎","🕯","🔧","🔨","🧲","🔬","🗡"], numberOfPairs: 6, color: "Purple")
        }
    }
    
    //Stuff from Prof
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themesArray), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themesArray = decodedThemes
        }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Intent
    
    func getTheme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themesArray.count - 1)
        return themesArray[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themesArray.count > 1, themesArray.indices.contains(index) {
            themesArray.remove(at: index)
        }
        return index % themesArray.count
    }
    
    //from Hunt. Needed here???
    func addEmojiToTheme(_ emoji:String, theme:Theme) {
//        themesArray[theme].append(emoji)
    }
    
    func insertTheme(named name: String, emojis: [String], numberOfPairs:Int, color:String, at index: Int = 0) {
        let unique = (themesArray.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theTheme = Theme(name: name, emojiArray: emojis, numberOfPairs: numberOfPairs, color:color, id:unique)
        let safeIndex = min(max(index, 0), themesArray.count)
        themesArray.insert(theTheme, at: safeIndex)
    }
}
