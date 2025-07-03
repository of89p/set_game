//
//  SetGame_ViewModel.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI

class SetGame_ViewModel: ObservableObject {
    struct cardCategory<categoryType> {
        var typeOne: categoryType
        var typeTwo: categoryType
        var typeThree: categoryType
    }

    var typeOfCards: [String: Any] = [
        "number": cardCategory<Int>(typeOne: 1, typeTwo: 2, typeThree: 3),
        "shape": cardCategory<String>(typeOne: "diamond", typeTwo: "squiggle", typeThree: "oval"),
        "shading": cardCategory<String>(typeOne: "solid", typeTwo: "stripped", typeThree: "open"),
        "color": cardCategory<Color>(typeOne: Color.red, typeTwo: Color.green, typeThree: Color.purple)
    ]
    
    @Published private var model = SetGame_Model()
}
