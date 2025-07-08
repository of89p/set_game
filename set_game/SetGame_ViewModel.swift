//
//  SetGame_ViewModel.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI


class SetGame_ViewModel: ObservableObject {
    @Published private var model: SetGame_Model<CardContent>
        
    struct CardContent: CardContentCompare {
        var contentAsArray: [String]
        
//        static func compare(_ lhs: CardContent, _ rhs: CardContent) -> Bool {
//            return false
//        }
        
        var number: String
        var shape: String
        var shading:String
        var color: String
    }
    
    
    private(set) var allCardContents: [CardContent]
    
    init(){
        allCardContents = SetGame_ViewModel.generateCardContent()
        model = SetGame_ViewModel.createSetGame(numberOfCards: allCardContents.count, allCardContents: allCardContents)
    }
    

    private static func createSetGame(numberOfCards: Int, allCardContents: [CardContent]) -> SetGame_Model<CardContent> {
        return SetGame_Model<CardContent>(numberOfCards: allCardContents.count){ index in
            return allCardContents[index]
        }
    }
    
    static let typeOfCards = [
        "number": ["1", "2", "3"],
        "shape": ["diamond", "squiggle", "oval"],
        "shading": ["solid", "stripped", "open"],
        "color": ["red", "green", "purple"]
    ]
    
    static func generateCardContent() -> [CardContent]{
        var returnArr: [CardContent] = []
        
        if let numbers = typeOfCards["number"],
           let shapes = typeOfCards["shape"],
           let shadings = typeOfCards["shading"],
           let colors = typeOfCards["color"]
        {
            for number in numbers {
                for shape in shapes {
                    for shading in shadings {
                        for color in colors {
//                            returnArr.append(CardContent(number: number, shape: shape, shading: shading, color: color, makeArray: [number, shape, shading, color]))
                            returnArr.append(CardContent(contentAsArray: [number, shape, shading, color], number: number, shape: shape, shading: shading, color: color))
                        }
                    }
                }
            }
        }
        
        return returnArr
    }
    
    var cards: Array<SetGame_Model<CardContent>.Card> {
       return model.cards.filter({$0.whereIsTheCard == SetGame_Model.cardLocation.onTable})
    }
    
    func choose(_ card: SetGame_Model<CardContent>.Card){
        model.choose(card)
    }
   
}
