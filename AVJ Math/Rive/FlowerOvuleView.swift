//
//  FlowerShape.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 31.03.24.
//

import SwiftUI

struct FlowerOvuleView: View {
    var body: some View {
        Canvas { context, size in
            let unit = size.width

            // Base
            let baseRect = CGRect(origin: .zero, size: CGSize(width: unit, height: unit))

            let basePath = Circle().path(in: baseRect)

            // Left eye
            let leftEyeRect = CGRect(
                origin: CGPoint(x: unit * 0.2, y: unit * 0.14),
                size: CGSize(width: unit * 0.29, height: unit * 0.4)
            )
            let leftEyePath = Ellipse().path(in: leftEyeRect)

            let leftPupilRect = CGRect(
                origin: CGPoint(x: unit * 0.23, y: unit * 0.3),
                size: CGSize(width: unit * 0.1, height: unit * 0.1)
            )
            let leftPupilPath = Circle().path(in: leftPupilRect)

            // Right eye
            let rightEyeRect = CGRect(
                origin: CGPoint(x: unit * 0.51, y: unit * 0.14),
                size: CGSize(width: unit * 0.29, height: unit * 0.4)
            )
            let rightEyePath = Ellipse().path(in: rightEyeRect)

            let rightPupilRect = CGRect(
                origin: CGPoint(x: unit * 0.54, y: unit * 0.3),
                size: CGSize(width: unit * 0.1, height: unit * 0.1)
            )
            let rightPupilPath = Circle().path(in: rightPupilRect)

            // Smile
            let smileRect = CGRect(
                origin: CGPoint(x: unit * 0.4, y: unit * 0.57),
                size: CGSize(width: unit * 0.22, height: unit * 0.12)
            )
            let smilePath = Smile().stroke(lineWidth: unit * 0.015).path(in: smileRect)

            // Cheeks
            let leftCheekRect = CGRect(
                origin: CGPoint(x: unit * 0.08, y: unit * 0.5),
                size: CGSize(width: unit * 0.15, height: unit * 0.1)
            )
            
            let rightCheekRect = CGRect(
                origin: CGPoint(x: unit * 0.78, y: unit * 0.5),
                size: CGSize(width: unit * 0.15, height: unit * 0.1)
            )

            // Fill
            context.fill(basePath, with: .color(Color("ovule")))

            context.fill(leftEyePath, with: .color(Color("eye")))
            context.fill(leftPupilPath, with: .color(Color("pupile")))

            context.fill(rightEyePath, with: .color(Color("eye")))
            context.fill(rightPupilPath, with: .color(Color("pupile")))

            context.fill(smilePath, with: .color(Color("smile")))

            context.draw(Image("CheekImage"), in: leftCheekRect)
            context.draw(Image("CheekImage"), in: rightCheekRect)
        }
    }
}

struct Smile: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }
}


#Preview("Flower") {
    FlowerOvuleView()
        .frame(width: 400, height: 400)
}

#Preview("Smile") {
    Smile()
        .stroke(lineWidth: 5)
        .frame(width: 600, height: 400)
}

