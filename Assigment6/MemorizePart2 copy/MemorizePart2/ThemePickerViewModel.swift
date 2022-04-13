//
//  ThemePickerViewModel.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 4/13/22.
//

import Foundation
//view model exposes the themes
//intets: add theme, delete thime, etc.

//The View Model object is an observed object
//@ObservedObject = someone else owns this thing, so it is created in another model?
//if it were an @StateObject, then it would be removed each time you go out of the panel, because it will be created when you tap on the button.

//class ThemePickerViewModel {
//    @Published var themes:[Theme<String>]
//
//    func addEmojiToTheme(_ emoji:String, theme:Theme) {
//        themes.append(emoji)
//    }
//}
