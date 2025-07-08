//
//  AspectVGrid.swift
//  set_game
//
//  Created by Terence Teo on 3/7/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView:View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let generatedMinimumSize = generateMinSize(
                size: geometry.size,
                numberOfCards: Double(items.count),
                aspectRatio: 2/3
            )
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: generatedMinimumSize), spacing: 0)], spacing: 0){
                    ForEach(items){ item in
                        content(item)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                    }
                }
            }
        }
    }
            
    func generateMinSize(size: CGSize, numberOfCards: Double, aspectRatio: CGFloat) -> CGFloat {
        var columnTry = 1.0
        
        repeat {
            let width = size.width / columnTry
            let height = width / aspectRatio
            let numberOfRows = (numberOfCards/columnTry).rounded(.up)
            if numberOfRows * height < size.height {
                return width.rounded(.down)
            }
            
            columnTry += 1
    
        } while columnTry < numberOfCards
        
        return 123
    }
}
