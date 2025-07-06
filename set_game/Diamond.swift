//
//  Diamond.swift
//  set_game
//
//  Created by Terence Teo on 5/7/25.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let sideLength = rect.width/2
        let height = sideLength / tan(Angle(degrees: 60).radians)
        let start = CGPoint(
            x: center.x,
            y: center.y - height
        )
        let westPoint = CGPoint(
            x: center.x + sideLength,
            y: center.y
        )
        let southPoint = CGPoint(
            x: center.x,
            y: center.y + height
        )
        let eastPoint = CGPoint(
            x: center.x - sideLength,
            y: center.y
        )
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: westPoint)
        p.addLine(to: southPoint)
        p.addLine(to: eastPoint)
        p.addLine(to: start)
        
        return p
    }
}
