//
//  ContentView.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGame_ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let generatedMinimumSize = generateMinSize(
                size: geometry.size,
                numberOfCards: 12,
                aspectRatio: 2/3
            )
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: generatedMinimumSize))]){
                    ForEach(viewModel.cards){ card in
                        CardView(number: "1", shape: "diamond", shading: "solid", color: "red")
                    }
                }.padding()
            }
        }
    }
    
    func generateMinSize(size: CGSize, numberOfCards: Double, aspectRatio: CGFloat) -> CGFloat {
//        var size: CGSize
//        var numberOfCards: Int
//        var aspectRatio: CGFloat
        
        var columnTry = 1.0
        
        repeat {
            let width = size.width / columnTry
            let height = width / aspectRatio
            let numberOfRows = (size.height / height).rounded(.up)
            
            if numberOfRows * height < size.height {
                return width.rounded(.down)
            }
            
            columnTry += 1
            
        } while columnTry < numberOfCards
        
        return 95
    }
}

#Preview {
    SetGameView(viewModel: SetGame_ViewModel())
}
