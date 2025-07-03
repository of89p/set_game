//
//  CardView.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI

struct CardView: View {
    let number: String
    let shape: String
    let shading: String
    let color: String
    
    @ViewBuilder
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        
        ZStack {
            base.strokeBorder(.orange)
            base.fill()
            VStack {
                ForEach(0..<Int(number)!, id: \.self){ _ in
                    Spacer()
                    switch shape {
                    case "diamond":
                        Circle().strokeBorder(.black).fill()
                    case "squiggle":
                        Rectangle().strokeBorder(.black).fill()
                    case "oval":
                        Capsule().strokeBorder(.black).fill()
                    default:
                        Ellipse().strokeBorder(.black).fill()
                    }
                        
                    Spacer()
                }
                .foregroundStyle(displayColor())
            }.padding().opacity(displayOpacity())
        }
        .foregroundStyle(.orange)
        .aspectRatio(2/3, contentMode: .fill)
    }
    
//    var numberOfStacks: some View {
//        for noOfStacks in number {
//            
//        }
//    }
    
    func displayColor() -> Color {
        let displayColor: Color
        switch color {
        case "red":
            displayColor = Color.red
        case "green":
            displayColor = Color.green
        case "purple":
            displayColor = Color.purple
        default:
            displayColor = Color.black
        }
        return displayColor
    }
    
    func displayOpacity() -> Double {
        switch shading {
        case "solid":
             1
        case "stripped":
             0.5
        case "open":
             0
        default:
             0
        }
    }
}

#Preview {
    CardView(number: "3", shape: "diamond", shading: "solid", color: "red")
}
//
//static let typeOfCards = [
//    "number": ["1","2","3"],
//    "shape": ["diamond", "squiggle", "oval"],
//    "shading": ["solid", "stripped", "open"],
//    "color": ["red", "green", "purple"]
//]
