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
    }
}

#Preview {
    SetGameView(viewModel: SetGame_ViewModel())
}
