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
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .animation(.easeIn , value: viewModel.cards)
        HStack{
            Button("Deal 3 more cards"){
                viewModel.addNewCards()
            }
            .disabled(viewModel.noCardsInDeck==0)
            
            Spacer()
            
            Button("New game"){
                viewModel.newGame()
            }
        }.padding()
    }
}  

#Preview {
    SetGameView(viewModel: SetGame_ViewModel())
}
