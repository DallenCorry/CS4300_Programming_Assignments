//  Model
//  MemoryGame.swift
//  MemorizePart2
//
//  Created by Dallen Corry on 1/28/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    //private(set)
    var cards: Array<Card> // you only want to this to be changed by the choose.
    var points: Int
    
    private var IndexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ( $0 == newValue) } }
    }
    
    func allAreMatched() -> Bool {
        var matched = true
        for card in cards {
            if !card.isMatched {
                matched = false
            }
        }
        return matched
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
       {
            if let potentialMatchIndex = IndexOfTheOneAndOnlyFaceUpCard {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    points += 2
                } else {
                    if cards[chosenIndex].seenBefore{
                        points -= 1
                    }
                    if cards[potentialMatchIndex].seenBefore {
                        points -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].seenBefore = true
                cards[potentialMatchIndex].seenBefore = true
            } else {
                IndexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //add number of pairs of cards x2
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        points = 0
    }
    
    struct Card: Identifiable {
        //actually called MemoryGame.Card. Nesting it clarifies that it is this game's card
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var seenBefore = false
        let content: CardContent //use generics (line 11)
        let id: Int//required to make it identifiable
        
        
        //BONUS TIME SHENANIGANS (from Stanford professor)
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}

/*This extension returns an element if it is the one and only element in the array. Otherwise it returns nil. (if there is one thing, return it, else return nil)
 */
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

