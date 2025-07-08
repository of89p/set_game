//
//  CardView.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGame_Model<SetGame_ViewModel.CardContent>.Card
    let card: Card
    let cardAspectRatio:CGFloat
    
    init(_ card: Card){
        self.card = card
        cardAspectRatio = (2/3)*3
    }
    
    @ViewBuilder
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            base.fill()
            
            if card.selectedWrong == SetGame_Model.cardSelectionStatus.isSet {
                base.strokeBorder(.green, lineWidth: 5)            }
            else if card.selectedWrong == SetGame_Model.cardSelectionStatus.notSet {
                base.strokeBorder(.red, lineWidth: 5)
            }
            
            VStack{
                ForEach(0..<Int(card.content.number)!, id: \.self){_ in
                    Spacer()
                    returnShape(card: card).aspectRatio(cardAspectRatio, contentMode: .fit)
                    Spacer()
                }
                
            }.padding(7)
        }
        .foregroundStyle(card.isSelected ? .orange : .black)
        .opacity(card.whereIsTheCard == SetGame_Model.cardLocation.inDeck ? 0 : 1)
    }
    
    
    @ViewBuilder
    func applyStroke(to shape: some Shape, whatColor: String, shading: String) -> some View {
        if shading == "open" {
            shape.stroke(displayColor(color: whatColor), lineWidth: 3)
        } else {
            shape.fill(displayColor(color: whatColor)).applyShading(opacityType: shading)
        }
    }

    func displayColor(color: String) -> Color {
        switch color {
        case "red":
            Color.red
        case "green":
            Color.green
        case "purple":
            Color.purple
        default:
            Color.black
        }
    }

    func returnShape(card: SetGame_Model<SetGame_ViewModel.CardContent>.Card) -> some View {
        Group{
            switch card.content.shape {
            case "diamond":
                applyStroke(to: Diamond(), whatColor: card.content.color, shading: card.content.shading)
            case "squiggle":
                applyStroke(to: Rectangle(), whatColor: card.content.color, shading: card.content.shading)
            case "oval":
                applyStroke(to: Capsule(), whatColor: card.content.color, shading: card.content.shading)
            default:
                Circle()
            }
        }
    }
}

#Preview {
//    CardView(number: "3", shape: "diamond", shading: "solid", color: "red")
}
