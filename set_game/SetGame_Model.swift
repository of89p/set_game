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
        print(numberOfCards)
        print(cards)
    }
    
    
    struct Card: Identifiable {
        var isMatched = false
        var isSelected = false
        var content: CardContent
        var id: Int
    }
}
