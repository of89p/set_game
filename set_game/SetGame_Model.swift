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
    
    enum cardSelectionStatusOptions{
        case notSelected
        case selected
        case selectedNotSet
        case selectedIsSet
    }
    
    
    struct Card: Equatable, Identifiable {
//        var isMatched = false
//        var isSelected = false
        var cardSelectionStatus = cardSelectionStatusOptions.notSelected
        var whereIsTheCard = cardLocation.inDeck
        var content: CardContent
        var id: Int
    }
    
    mutating func addNewCards() -> Void {
        var needToDealMoreCards = true
        let indicesOfCardsInDeck = cards.indices.filter({cards[$0].whereIsTheCard == cardLocation.inDeck})
        
        if numberOfCardsSelected() == 3 {
            needToDealMoreCards = !dealWithThreePrevSelectedCards()
        }
        
        if needToDealMoreCards {
            for index in 0..<max(0, 3){
                cards[indicesOfCardsInDeck[index]].whereIsTheCard = cardLocation.onTable
            }
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenCardIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if cards[chosenCardIndex].cardSelectionStatus != cardSelectionStatusOptions.selectedIsSet && cards[chosenCardIndex].cardSelectionStatus !=  cardSelectionStatusOptions.selectedNotSet {
                
                toggleThisCard(cardIndex: chosenCardIndex)
                
                let arrOfSelectedCards = cards.indices.filter{cards[$0].cardSelectionStatus != cardSelectionStatusOptions.notSelected}

                switch numberOfCardsSelected() {
                case 3:
                    let firstCard = cards[arrOfSelectedCards[0]].content.contentAsArray
                    let secondCard = cards[arrOfSelectedCards[1]].content.contentAsArray
                    let thirdCard = cards[arrOfSelectedCards[2]].content.contentAsArray
                    
                    let firstAndSecondComparison = compareTwoCards(firstCard, secondCard)
                    let secondAndThirdComparison = compareTwoCards(secondCard, thirdCard)
                    let firstAndThirdComparison = compareTwoCards(firstCard, thirdCard)
                                        
                    if doTheyMatch(firstAndSecondComparison, secondAndThirdComparison, firstAndThirdComparison) {
                        for index in 0..<3 {
                            cards[arrOfSelectedCards[index]].cardSelectionStatus = cardSelectionStatusOptions.selectedIsSet
                        }
                    } else {
                        for index in 0..<3 {
                            cards[arrOfSelectedCards[index]].cardSelectionStatus = cardSelectionStatusOptions.selectedNotSet
                        }
                    }
                    
                case 4:
                    _ = dealWithThreePrevSelectedCards()
//                    cards[arrOfSelectedCards[0]].cardSelectionStatus = cardSelectionStatusOptions.selected
                default:
                    break
                }
            }
        }
    }
    
    mutating func dealWithThreePrevSelectedCards() -> Bool {
        var returnIsSetOrNot = false
        
        let indicesOfCardsInDeck = cards.indices.filter({cards[$0].whereIsTheCard == cardLocation.inDeck})
        
        // If set, replace matched card
        let indicesOfCardsInSet = cards.indices.filter({cards[$0].cardSelectionStatus == cardSelectionStatusOptions.selectedIsSet})

        if indicesOfCardsInSet.count == 3 {
            for (i, index) in indicesOfCardsInSet.enumerated() {
                cards[index].cardSelectionStatus = cardSelectionStatusOptions.notSelected
                cards[index].whereIsTheCard = cardLocation.alreadyMatched
                
                if indicesOfCardsInDeck.count > 0{
                    cards[indicesOfCardsInDeck[i]].whereIsTheCard = cardLocation.onTable
                    let tempVar = cards[index]
                    cards[index] = cards[indicesOfCardsInDeck[i]]
                    cards[indicesOfCardsInDeck[i]] = tempVar
                }
            }
            returnIsSetOrNot = true
        }
        
        // By default set all cards to notSelected
        let indicesOfCardsAlreadySelected = cards.indices.filter({cards[$0].cardSelectionStatus == cardSelectionStatusOptions.selectedIsSet || cards[$0].cardSelectionStatus == cardSelectionStatusOptions.selectedNotSet})
        for index in indicesOfCardsAlreadySelected {
            cards[index].cardSelectionStatus = cardSelectionStatusOptions.notSelected
        }
        
        return returnIsSetOrNot
    }
    
    mutating func toggleThisCard(cardIndex: Int){
        if(cards[cardIndex].cardSelectionStatus == cardSelectionStatusOptions.notSelected) {
            cards[cardIndex].cardSelectionStatus = cardSelectionStatusOptions.selected
        } else {
            cards[cardIndex].cardSelectionStatus = cardSelectionStatusOptions.notSelected
        }
    }
    
    func numberOfCardsSelected() -> Int {
        cards.indices.filter{cards[$0].cardSelectionStatus != cardSelectionStatusOptions.notSelected}.count
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










// Card is selected
// Changed cardSelectionStatus to ??? --> call determineCardSelectionStatus()
// func determineCardSelectionStatus() --> numberOfCardsSelected()
//       if third card
                // check if they are a set --> use doTheyMatch()
                // updated cardSelectionStatus to cardSelectionStatusOptions.selectedNotSet or cardSelectionStatusOptions.selectedIsSet accordingly
//       if fourth card
                // dealWithThreePrevSelectedCards()
                // change 4th card to cardSelectionStatusOptions.selected
//       if first or second card
                // toggle cardSelectionStatus between cardSelectionStatusOptions.selected & cardSelectionStatusOptions.notSelected



// Deal new cards button is selected
// call numberOfCardsSelected()
// dealWithThreePrevSelectedCards ()


// func dealWithThreePrevSelectedCards()
        // if set (check by filtering for cardSelectionStatusOptions.selectedIsSet == 3)
                // change whereIsTheCard = cardLocation.alreadyMatched
                // call replaceMatchedCards()
        // by default: change all 3 prev cards cardSelectionStatus = cardSelectionStatusOptions.notSelected

