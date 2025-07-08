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

struct SetGame_Model<CardContent: CardContentCompare> where CardContent: Equatable{

    
    private(set) var cards: [Card]
    
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        for index in 0..<numberOfCards{
            cards.append(Card(content: cardContentFactory(index), id:index))
        }
        
        cards.shuffle()
        
        for index in 0..<12{
            cards[index].whereIsTheCard = cardLocation.onTable
        }
    }
    
    enum cardLocation {
        case inDeck
        case onTable
        case alreadyMatched
    }
    
    enum cardSelectionStatus{
        case isSet
        case notSet
        case notChosen
    }
    
    
    struct Card: Equatable, Identifiable {
        var isMatched = false
        var isSelected = false
        var selectedWrong = cardSelectionStatus.notChosen
        var whereIsTheCard = cardLocation.inDeck
        var content: CardContent
        var id: Int
    }
    
    mutating func addNewCards() -> Void {
        let indicesOfCardsInDeck = cards.indices.filter({cards[$0].whereIsTheCard == cardLocation.inDeck})
        if let cardIndexOfCardInSet = x() {
            for index in 0..<cardIndexOfCardInSet.count {
                cards[indicesOfCardsInDeck[index]].whereIsTheCard = cardLocation.onTable
                let tempVar = cards[cardIndexOfCardInSet[index]]
                cards[cardIndexOfCardInSet[index]] = cards[indicesOfCardsInDeck[index]]
                cards[indicesOfCardsInDeck[index]] = tempVar
            }
        } else {
            for index in 0..<max(0, 3){
                cards[indicesOfCardsInDeck[index]].whereIsTheCard = cardLocation.onTable
            }
            
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenCardIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if cards[chosenCardIndex].selectedWrong == cardSelectionStatus.notChosen {
                    cards[chosenCardIndex].isSelected.toggle()
                    x()
                }
        }
    }

    mutating func x() -> [Int]? {
        let cardsSelectedIndex = cards.indices.filter{cards[$0].isSelected}
        
        if cardsSelectedIndex.count == 3 {
            let firstCard = cards[cardsSelectedIndex[0]].content.contentAsArray
            let secondCard = cards[cardsSelectedIndex[1]].content.contentAsArray
            let thirdCard = cards[cardsSelectedIndex[2]].content.contentAsArray
            
            let firstAndSecondComparison = compareTwoCards(firstCard, secondCard)
            let secondAndThirdComparison = compareTwoCards(secondCard, thirdCard)
            let firstAndThirdComparison = compareTwoCards(firstCard, thirdCard)
            
//                print(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison, doTheyMatch(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison))
            
            if doTheyMatch(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison) {
                for index in 0..<3 {
                    cards[cardsSelectedIndex[index]].isMatched = true
                    cards[cardsSelectedIndex[index]].selectedWrong = cardSelectionStatus.isSet
//                    cards[cardsSelectedIndex[index]].isSelected = false
//                    cards[cardsSelectedIndex[index]].whereIsTheCard = cardLocation.alreadyMatched
                }
                return cardsSelectedIndex
            } else {
                for index in 0..<3 {
                    cards[cardsSelectedIndex[index]].selectedWrong = cardSelectionStatus.notSet
//                    cards[cardsSelectedIndex[index]].isSelected = false
                }
                return cardsSelectedIndex
            }
        } else if cardsSelectedIndex.count == 4 {
            let firstThreeSelectedIndex = cards.indices.filter{cards[$0].selectedWrong != cardSelectionStatus.notChosen}
            if cards[firstThreeSelectedIndex[0]].selectedWrong == cardSelectionStatus.isSet {
                for index in 0..<3 {
                    cards[firstThreeSelectedIndex[index]].whereIsTheCard = cardLocation.alreadyMatched
                    cards[firstThreeSelectedIndex[index]].isSelected = false
                    cards[firstThreeSelectedIndex[index]].selectedWrong = cardSelectionStatus.notChosen
                }
            } else if cards[firstThreeSelectedIndex[0]].selectedWrong == cardSelectionStatus.notSet{
                for index in 0..<3 {
                    cards[firstThreeSelectedIndex[index]].selectedWrong = cardSelectionStatus.notChosen
                    cards[firstThreeSelectedIndex[index]].isSelected = false
                }
            }
        }
        return nil
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
    }
}
