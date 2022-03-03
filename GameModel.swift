//
//  GameModel.swift
//  Set
//
//  Model for Assignment three in CS 4300
//  Created by Dallen Corry on 2/14/22.
//said that here we should have animation for the dealing>
import Foundation

struct GameModel{
    let cardsArray: Array<Card>
    var cardsOnScreen: Array<Card>
    var numberOfCardsOnScreen: Int
    var points: Int = 0 //EC
    
    init () {
        numberOfCardsOnScreen = 12
        cardsArray = Self.makeCards()
        cardsOnScreen = Array(cardsArray.shuffled().prefix(numberOfCardsOnScreen))
    }
    
//    init (numberOfCardsOnScreen: Int) {
//        self.numberOfCardsOnScreen = numberOfCardsOnScreen
//        cardsArray = Self.makeCards()
//        let tempArray = cardsArray.shuffled()
//        cardsOnScreen = Array(tempArray.prefix(numberOfCardsOnScreen))
//    }
    
    init (cardsArray: [Card], numberOfCardsOnScreen: Int) {
        self.numberOfCardsOnScreen = numberOfCardsOnScreen
        self.cardsArray = cardsArray
        cardsOnScreen = Array(cardsArray.prefix(numberOfCardsOnScreen))
        print(numberOfCardsOnScreen)
    }

    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false//NOT NEEDED
        var isMatched = false
        var isSelected = false
        let content: String//CardContent //use generics (line 11) NOT NEEDED
        //4 attributes with 3 states each. Try using an enum?
        var color: myColor
        var number: Number
        var shape: myShape
        var shading: Shading
        
        init(content: String){//CardContent){
            id = 1
            self.content = content
            color = myColor.Green
            number = Number.One
            shape = myShape.Diamond
            shading = Shading.Open
        }
        
        init(id: Int, content: String/*CardContent*/, color:myColor, number: Number, shape:myShape, shading: Shading) {
            self.id = id
            self.content = content
            self.color = color
            self.number = number
            self.shape = shape
            self.shading = shading
        }
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
        case Rectangle
        case Diamond
        case Oval
        
//        func allSame (_ arr: [myShape]) {
//            if arr[0] == arr[1] && arr[0] == arr[2] {
//
//            }
//        }
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
        myColor.allCases.forEach({ color in
            Number.allCases.forEach({ number in
                myShape.allCases.forEach({ shape in
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
    
    
    
    func isSame<T:Equatable>(one: T, two: T, three: T) -> Bool {
        one == two && two == three
    }
    
    func isDistinct<T:Equatable>(one: T, two: T, three: T) -> Bool {
        one != two && one != three && two != three
    }
    
    
    func isMatched(card1: Card, card2:Card, card3:Card) -> Bool {
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
    
    mutating func chooseCard(_ card:Card) {
        if let chosenIndex = cardsOnScreen.firstIndex(where: { $0.id == card.id}) {
            cardsOnScreen[chosenIndex].isSelected.toggle()
            print(card.number, card.shading, card.color, card.shape)
        }
    }
    
    mutating func addCards() {
//        numberOfCardsOnScreen += 3
//        cardsOnScreen.shuffle()
    }
}
