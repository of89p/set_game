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
                    Text("🙈")
                    Spacer()
                }
            }.padding()
        }
        .foregroundStyle(.orange)
        .aspectRatio(2/3, contentMode: .fill)
    }
    
//    var numberOfStacks: some View {
//        for noOfStacks in number {
//            
//        }
//    }
}

#Preview {
    CardView(number: "1", shape: "diamond", shading: "solid", color: "red")
}
//
//static let typeOfCards = [
//    "number": ["1","2","3"],
//    "shape": ["diamond", "squiggle", "oval"],
//    "shading": ["solid", "stripped", "open"],
//    "color": ["red", "green", "purple"]
//]
