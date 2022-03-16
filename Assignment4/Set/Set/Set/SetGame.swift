//
//  SetGame.swift
//  Set
//
//  View model
//  Created by Dallen Corry on 2/14/22.
//
import SwiftUI

class SetGame: ObservableObject {
    var tempBool = false
    @Published var model = createModel()
    
    var cards: Array<GameModel.Card> {
        model.cardsOnScreen
    }
    
    private static func createModel() -> GameModel {
        return GameModel()
    }
    
    init() {
        model = Self.createModel()
    }
    
    func chooseCard(_ card: GameModel.Card) {
        model.chooseCard(card)
    }
    
    func addCards() {
            model.addCards()
        }

    func newGame() {
        model = Self.createModel()
    }
}
