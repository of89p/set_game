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
    
    init(_ card: Card){
        self.card = card
    }
    
    @ViewBuilder
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack {
            base.strokeBorder(.orange)
            base.fill()
            VStack {
//                ForEach(0..<Int(card.content.number)!){_ in
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
//                }
            } .padding()
        }
        .foregroundStyle(.orange)
        .aspectRatio(2/3, contentMode: .fill)
    }
}


@ViewBuilder
func applyStroke(to shape: some Shape, whatColor: String, shading: String) -> some View {
    if shading == "open" {
        shape.stroke(displayColor(color: whatColor))
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


#Preview {
//    CardView(number: "3", shape: "diamond", shading: "solid", color: "red")
}
