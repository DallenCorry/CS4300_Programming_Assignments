//
//  GameModel.swift
//  Set
//
//  Model for Assignment three in CS 4300
//  Created by Dallen Corry on 2/14/22.
//

import Foundation

struct GameModel{//}<CardContent> {
    let cardsArray: Array<Card>
    var cardsOnScreen: Array<Card>
    var numberOfCardsOnScreen = 12
    var points: Int = 0
    
    init () {
        cardsArray = Self.makeCards()
        cardsOnScreen = Array(cardsArray.shuffled().prefix(numberOfCardsOnScreen))
    }
    
    init (cardsArray: [Card]) {
        self.cardsArray = cardsArray
        cardsOnScreen = cardsArray.shuffled()
    }
    
//    init (myArrayForTesting: [String]) {
//        self.myArrayForTesting = myArrayForTesting
//        cardsArray = Array<Card>()
//        points = 0
//    }
    
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        var seenBefore = false
        let content: String//CardContent //use generics (line 11)
        //4 attributes with 3 states each. Try using an enum?
        var color: Color
        var number: Number
        var shape: Shape
        var shading: Shading
        
        init(content: String){//CardContent){
            id = 1
            self.content = content
            color = Color.Green
            number = Number.One
            shape = Shape.Diamond
            shading = Shading.Open
        }
        
        init(id: Int, content: String/*CardContent*/, color:Color, number: Number, shape:Shape, shading: Shading) {
            self.id = id
            self.content = content
            self.color = color
            self.number = number
            self.shape = shape
            self.shading = shading
        }
    }
    
    enum Color: CaseIterable {
        case Green
        case Purple
        case Red
    }
    
    enum Number: CaseIterable {
        case One
        case Two
        case Three
    }
    
    enum Shape: CaseIterable {
        case Squiggle
        case Diamond
        case Oval
        
        func allSame (_ arr: [Shape]) {
            if arr[0] == arr[1] && arr[0] == arr[2] {
                
            }
        }
    }
    
    enum Shading: CaseIterable {
        case Solid
        case Stripes
        case Open
    }
    
    
    static func makeCards() -> [Card]{
        var cards = [Card]()
        var myId :Int = 0
//        let myContent: CardContent
        Color.allCases.forEach({ color in
            Number.allCases.forEach({ number in
                Shape.allCases.forEach({ shape in
                    Shading.allCases.forEach({ shading in
                        myId += 1
                        cards.append(Card(id:myId, content: "Card \(myId)", color:color, number: number, shape:shape, shading: shading))
                    })
                })
            })
        })
//        print(cards)
        return cards
    }
    
    func isMatched() -> Bool {
        let matchColor = true
        let matchNumber = true
        let matchShape = true
        let matchShading = true
        return matchColor && matchNumber && matchShape && matchShading
    }
}
