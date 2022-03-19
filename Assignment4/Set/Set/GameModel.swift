//
//  GameModel.swift
//  Set
//
//  Model for Assignment three in CS 4300
//  Created by Dallen Corry on 2/14/22.
//  said that here we should have animation for the dealing>
import Foundation
struct GameModel {
    var undeltCards: [Card]
    var cardsOnScreen: [Card]
    var discardedCards: [Card] = [Card]()
    var selectedCards: [Card] = [Card]()
    var initialNumberOfCardsOnScreen: Int
    static var cheating = false
    
    init () {
        self.init(initialNumberOfCardsOnScreen: 0)
    }
    
    init (initialNumberOfCardsOnScreen num:Int) {
        initialNumberOfCardsOnScreen = num
        undeltCards = Self.makeCards().shuffled()
        cardsOnScreen = [Card]()
        discardedCards = [Card]()
        selectedCards = [Card]()
        addCardsToScreen(initialNumberOfCardsOnScreen)
    }

    struct Card: Identifiable {
        let id: Int
        let rotation = Double.random(in: -10...15)
        var isFaceUp = false
        var isMatched = false
        var isSelected = false
        var threeCardsSelected = false
        var color: myColor
        var number: Number
        var shape: myShape
        var shading: Shading
    }
    
    enum myColor: CaseIterable {
        case Green
        case Purple
        case Orange
    }
    
    enum Number: CaseIterable {
        case One
        case Two
        case Three
    }
    
    enum myShape: CaseIterable {
        case Squiggle
        case Diamond
        case Oval
    }
    
    enum Shading: CaseIterable {
        case Solid
        case Stripes
        case Open
    }
    
    static func makeCards() -> [Card]{
        var cards = [Card]()
        var myId :Int = 0
        myColor.allCases.forEach({ color in
            Number.allCases.forEach({ number in
                myShape.allCases.forEach({ shape in
                    Shading.allCases.forEach({ shading in
                        myId += 1
                        cards.append(Card(id:myId, color:color, number: number, shape:shape, shading: shading))
                    })
                })
            })
        })
        return cards
    }
    
    mutating func clearAllCards() {
        discardedCards = [Card]()
        cardsOnScreen = [Card]()
        selectedCards = [Card]()
        undeltCards = []
    }
    
    private static func isSame<T:Equatable>(one: T, two: T, three: T) -> Bool {
        one == two && one == three
    }
    
    private static func isDistinct<T:Equatable>(one: T, two: T, three: T) -> Bool {
        one != two && one != three && two != three
    }
    
    static func areMatched(card1: Card, card2:Card, card3:Card) -> Bool {
        if cheating {
            //for testing purposes only!
            print("WARNING!! You are in developer mode! change GameModel line 15 to false to play")
            return true
        } else {
            let colorMatch =
                isSame(one: card1.color, two: card2.color, three: card3.color) ||
                isDistinct(one: card1.color, two: card2.color, three: card3.color)
            let numberMatch =
                isSame(one: card1.number, two: card2.number, three: card3.number) ||
                isDistinct(one: card1.number, two: card2.number, three: card3.number)
            let shapeMatch =
                isSame(one: card1.shape, two: card2.shape, three: card3.shape) ||
                isDistinct(one: card1.shape, two: card2.shape, three: card3.shape)
            let shadingMatch =
                isSame(one: card1.shading, two: card2.shading, three: card3.shading) ||
                isDistinct(one: card1.shading, two: card2.shading, three: card3.shading)
            return colorMatch && numberMatch && shapeMatch && shadingMatch
        }
    }
    
    mutating func addCardsFromTheDeckButton(_ num:Int) {
            if let _ = cardsOnScreen.firstIndex(where: { $0.isMatched}) {
                replaceCards(num, replace: true)
                selectedCards.removeAll()
            } else {
                addCardsToScreen(num)
            }
    }

    mutating func addCardsToScreen(_ num:Int) {
        if undeltCards.count > 0 {
            for _ in 0..<num {
                cardsOnScreen.append(undeltCards[0])
                cardsOnScreen[cardsOnScreen.count-1].isFaceUp = true
                undeltCards.remove(at:0)
            }
        } else {
            print("no cards remaining")
        }
    }
    
    mutating func replaceCards(_ num:Int, replace:Bool) {
        for _ in 0..<num {
            if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.isMatched}) {
                if replace {
                    discardedCards.append(cardsOnScreen[chosenIndex])
                    cardsOnScreen[chosenIndex] = undeltCards[0]
                    cardsOnScreen[chosenIndex].isFaceUp = true
                    undeltCards.remove(at:0)
                } else {
                    discardedCards.append(cardsOnScreen[chosenIndex])
                    cardsOnScreen.remove(at: chosenIndex)
                }
            }
        }
    }
    
    mutating func remove3Matched() {
        //remove the 3 from screen, and add 3 more if there are less than 12 cards and at least 3 cards in the deck
//        let myBool = (cardsOnScreen.count <= 12 && undeltCards.count >= 3)
        replaceCards(3,replace:false)
        
        //reset all onscreen matches and selections
        cardsOnScreen.indices.forEach { cardsOnScreen[$0].isSelected = false; cardsOnScreen[$0].threeCardsSelected = false; cardsOnScreen[$0].isMatched = false}
        selectedCards.removeAll()
        
        //win condition: no cards left
        if undeltCards.count == 0 && cardsOnScreen.count == 0 {
            print ("You won!")
        }
    }
    
    mutating func myShuffle() {
        cardsOnScreen.shuffle()
    }
    
    mutating func chooseCard(_ card:Card) {
        if selectedCards.count == 3 {
            //check the match
            selectedCards.indices.forEach { selectedCards[$0].isMatched = GameModel.areMatched(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2])
            }
            if !selectedCards[0].isMatched {
                //Deselect All
                cardsOnScreen.indices.forEach { cardsOnScreen[$0].isSelected = false; cardsOnScreen[$0].threeCardsSelected = false }
                selectedCards.removeAll()
                //select 4th card
                if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.id == card.id }) {
                    cardsOnScreen[chosenIndex].isSelected = true
                    selectedCards.append(cardsOnScreen[chosenIndex])
                }
            } else {
                //remove matched cards
                remove3Matched()
                if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.id == card.id }) {
                    cardsOnScreen[chosenIndex].isSelected = true
                    selectedCards.append(cardsOnScreen[chosenIndex])
                }
            }
        } else
        if card.isSelected {
            if selectedCards.count < 3 {
                //deselect that card
                if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.id == card.id }) {
                    cardsOnScreen[chosenIndex].isSelected = false
                    if let selectedIndex = selectedCards.firstIndex(where: { $0.id == cardsOnScreen[chosenIndex].id }) {
                        selectedCards.remove(at: selectedIndex)
                    }
                }
            }
        } else {
            //select
            if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.id == card.id }) {
                cardsOnScreen[chosenIndex].isSelected = true
                selectedCards.append(cardsOnScreen[chosenIndex])
            }
            //check the match
            if selectedCards.count > 2 {
                for theIndex in 0..<3 {
                    cardsOnScreen.indices.forEach {
                        if cardsOnScreen[$0].id == selectedCards[theIndex].id {
                            cardsOnScreen[$0].threeCardsSelected = true
                            //if matching, set 3 cards isMatched to true
                            if GameModel.areMatched(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
                                cardsOnScreen[$0].isMatched = true
                            }
                        }
                    }
                }
            }
        }
     }
}
