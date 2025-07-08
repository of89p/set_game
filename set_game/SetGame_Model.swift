//
//  SetGame_Model.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import Foundation

protocol CardContentCompare {
    var contentAsArray: [String] {get}
}

struct SetGame_Model<CardContent: CardContentCompare>{

    
    private(set) var cards: [Card]
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        for index in 0..<numberOfCards{
            cards.append(Card(content: cardContentFactory(index), id:index))
        }
        
        cards.shuffle()
        
        for index in 0..<30 {
            cards[index].whereIsTheCard = cardLocation.onTable
        }
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
            cards[chosenCardIndex].isSelected.toggle()
            var cardsSelectedIndex = cards.indices.filter{cards[$0].isSelected}

            if cardsSelectedIndex.count == 3 {
                let firstCard = cards[cardsSelectedIndex[0]].content.contentAsArray
                let secondCard = cards[cardsSelectedIndex[1]].content.contentAsArray
                let thirdCard = cards[cardsSelectedIndex[2]].content.contentAsArray
                
                let firstAndSecondComparison = compareTwoCards(firstCard, secondCard)
                let secondAndThirdComparison = compareTwoCards(secondCard, thirdCard)
                let firstAndThirdComparison = compareTwoCards(firstCard, thirdCard)
                
                print(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison, doTheyMatch(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison))
                
                if doTheyMatch(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison) {
                    cards[cardsSelectedIndex[0]].isMatched = true
                    cards[cardsSelectedIndex[1]].isMatched = true
                    cards[cardsSelectedIndex[2]].isMatched = true
                    cards[cardsSelectedIndex[0]].whereIsTheCard = cardLocation.alreadyMatched
                    cards[cardsSelectedIndex[1]].whereIsTheCard = cardLocation.alreadyMatched
                    cards[cardsSelectedIndex[2]].whereIsTheCard = cardLocation.alreadyMatched
                }
            }
        }
    }
    
    func compareTwoCards(_ lhs: [String], _ rhs: [String]) -> [Bool] {
        var returnArr: [Bool] = []
        for index in 0..<lhs.count {
            returnArr.append(lhs[index] == rhs[index])
        }
        return returnArr
    }
    
    func doTheyMatch(_ firstComparison: [Bool], _ secondComparison: [Bool], _ thirdComparison: [Bool]) -> Bool{
        return firstComparison == secondComparison && secondComparison == thirdComparison
//        for index in 0..<firstComparison.count {
//            if firstComparison[index] == secondComparison[index] && secondComparison[index] == thirdComparison[index]{
//                return false
//            }
//        }
//        return true
    }
}
