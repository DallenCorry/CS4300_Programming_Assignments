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
        tempBool.toggle()
        model = GameModel(cardsArray: cards, numberOfCardsOnScreen: 10)
        model.cardsOnScreen.indices.forEach { model.cardsOnScreen[$0].isSelected = false }//this needs to change if I want to keep the selection when the button is pushed. (Because right now it is being set to empty each time new cards are added.)
//        if (tempBool){
//            model = GameModel(cardsArray: cards, numberOfCardsOnScreen: model.numberOfCardsOnScreen - 1)
//        } else {
//            model = GameModel(cardsArray: cards, numberOfCardsOnScreen: model.numberOfCardsOnScreen + 1)
//        }
    }
}
