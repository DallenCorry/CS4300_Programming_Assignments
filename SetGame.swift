//
//  SetGame.swift
//  Set
//
//  View model
//  Created by Dallen Corry on 2/14/22.
//

import SwiftUI

class SetGame: ObservableObject {
    //here is where I should set the shapes of my card, with their colors, numbers etc.
    var model = createModel()
    
    var cards: Array<GameModel.Card> {
        model.cardsOnScreen
    }
    
    private static func createModel() -> GameModel {
        return GameModel()
    }
    
    init() {
        model = Self.createModel()
    }
}
