//
//  SetGame_Model.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import Foundation

struct SetGame_Model<CardContent>{
    private(set) var cards: [Card]
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        for index in 0..<numberOfCards{
            cards.append(Card(content: cardContentFactory(index), id:index))
        }
        
        cards.shuffle()
        
        for index in 0..<14 {
            cards[index].whereIsTheCard = cardLocation.onTable
        }
        
//        var cardsIndices = [0...81]
//        var noOfCardsAlreadyMadeOnTable = 0
//        repeat {
//            
//            
//            noOfCardsAlreadyMadeOnTable += 1
//        } while noOfCardsAlreadyMadeOnTable < 13
    }
    
    enum cardLocation {
        case inDeck
        case onTable
        case alreadyMatched
    }
    
    
    struct Card: Identifiable {
        var isMatched = false
        var isSelected = false
        var whereIsTheCard = cardLocation.inDeck
        var content: CardContent
        var id: Int
    }
    
    mutating func choose(_ card: Card){
        if let chosenCardIndex = cards.firstIndex(where: {$0.id == card.id}) {
            let numberOfCardsSelected = cards.filter{$0.isSelected}.count
            if numberOfCardsSelected < 2 {
                cards[chosenCardIndex].isSelected.toggle()
            }
        }
    }
}
