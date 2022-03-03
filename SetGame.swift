//
//  SetGame.swift
//  Set
//
//  View model
//  Created by Dallen Corry on 2/14/22.
//
import SwiftUI

class SetGame: ObservableObject {
    //here is where I should set the shapes(Content?) of my card, with their colors, numbers etc.
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
    
    //unused
    var theBodyOfTheCard: some View {
        return Text("AHH")
    }
    
    func chooseCard(_ card: GameModel.Card) {
        model.chooseCard(card)
    }
    
    func addCards(_ number:Int) {
//        let num = model.numberOfCardsOnScreen
        model = GameModel(cardsArray: cards, numberOfCardsOnScreen: 10)
       
    }
}
