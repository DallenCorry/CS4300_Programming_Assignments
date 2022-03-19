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
    @Published var model = createModel(0)
    
    var cards: Array<GameModel.Card> {
        model.cardsOnScreen
    }
    
    var undeltCards: [GameModel.Card] {
        model.undeltCards
    }
    
    var discardPile: [GameModel.Card] {
        model.discardedCards
    }
    
    private static func createModel(_ num:Int) -> GameModel {
        return GameModel(initialNumberOfCardsOnScreen:num)
    }
    
    init() {
        model = Self.createModel(0)
    }
    
    func chooseCard(_ card: GameModel.Card) {
        model.chooseCard(card)
    }
    
    func addCards(_ num:Int) {
            model.addCardsFromTheDeckButton(num)
        }

    func newGame() {
        model.clearAllCards()
        model = Self.createModel(12)
    }
    
    func myShuffle() {
        model.myShuffle()
    }
}
