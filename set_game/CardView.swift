//
//  CardView.swift
//  set_game
//
//  Created by Terence Teo on 2/7/25.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        
        ZStack {
            base.strokeBorder(.orange)
            base.fill()
        }
        .foregroundStyle(.orange)
        .aspectRatio(2/3, contentMode: .fill)
    }
}

#Preview {
    
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
        CardView()
        CardView()
    }.padding()
}
