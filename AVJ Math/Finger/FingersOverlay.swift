//
//  FingerOverlayView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 29.02.24.
//

import SwiftUI

let arcRadius: CGFloat = 10

struct FingersOverlay: Shape {
    let handPoints: [FingerPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for point in handPoints {
            let screenPoint = screenPoint(from: point.point, in: rect)
            let arcPoint = arcPoint(screenPoint: screenPoint)

            path.move(to: arcPoint)
            path.addArc(center: screenPoint, radius: arcRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
        return path
    }

    private func screenPoint(from normalisedPoint: CGPoint, in rect: CGRect) -> CGPoint {
        CGPoint(x: normalisedPoint.x * rect.width, y: normalisedPoint.y * rect.height)
    }

    private func arcPoint(screenPoint: CGPoint) -> CGPoint {
        CGPoint(x: screenPoint.x + arcRadius, y: screenPoint.y)
    }
}

#Preview {
    Group {
        FingersOverlay(handPoints: [
            FingerPoint(isCounted: true, point: CGPoint(x: 0.9, y: 0.5)),
            FingerPoint(isCounted: true, point: CGPoint(x: 0.5, y: 0.1)),
            FingerPoint(isCounted: false, point: CGPoint(x: 0.2, y: 0.2)),
            FingerPoint(isCounted: false, point: CGPoint(x: 0.2, y: 0.8)),
        ])
    }
}
