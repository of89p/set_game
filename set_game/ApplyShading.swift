//
//  Capsule.swift
//  set_game
//
//  Created by Terence Teo on 3/7/25.
//

import SwiftUI
import CoreGraphics

struct ApplyShading: ViewModifier {
    let opacityType: String
    
    func body(content: Content) -> some View {
        Group {
            content
                .opacity(displayOpacity(opacityType: opacityType))
//                .aspectRatio(2/1, contentMode:.fill)
        }
    }
    
    func displayOpacity(opacityType: String) -> Double {
        switch opacityType {
        case "solid":
             1
        case "stripped":
            0.5
        default:
             1
        }
    }
}

extension View {
    func applyShading(opacityType: String) -> some View {
        modifier(ApplyShading(opacityType: opacityType))
    }
}
