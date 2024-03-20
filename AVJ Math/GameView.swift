//
//  ContentView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct GameView: View {
    @State private var gameVM = GameVM()

    @State private var fingerVM = FingerCountVM()
    @State private var cardVM = CardCountVM()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(gameVM.searchedNumber.description)
                    .font(.largeTitle)

                Spacer()
                Text("\(gameVM.correctAnswerCount) ✅")
            }
                .padding()
                .background(gameVM.correctAnswer ? .green.opacity(0.3) : .black.opacity(0.8))

            GeometryReader { geo in
                ZStack {
                    CountView(
                        vm: CountVM(newCountCallback: gameVM.newFingerCount),
                        fingerVM: fingerVM,
                        cardVM: cardVM
                    )

//                    FingersOverlay(handPoints: fingerVM.points.filter { $0.isCounted })
//                        .foregroundStyle(.indigo)

                    FingerFlower(index: 0, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 1, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 2, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 3, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 4, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)

                    FingerFlower(index: 5, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 6, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 7, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 8, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 9, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)

                    FingerFlower(index: 10, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 11, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 12, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 13, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 14, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)

                    FingerFlower(index: 15, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 16, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 17, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 18, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                    FingerFlower(index: 19, isOpen: gameVM.correctAnswer, fingers: fingerVM.points, geo: geo)
                }
                .flipped(.horizontal)
            }
        }
        .toolbar {
            Picker("Game mode", selection: $gameVM.mode) {
                ForEach(GameMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct FingerFlower: View {
    let index: Int
    let isOpen: Bool

    let fingers: [FingerPoint]
    let geo: GeometryProxy

    var point: CGPoint? {
        if fingers.count > index {
            let finger = fingers[index]

            if finger.isCounted {
                return finger.point
            }
        }
        return nil
    }

    var body: some View {
        if let point = point {
            FlowerView(isOpen: isOpen, color: "violet")
                .position(
                    x: point.x * geo.size.width,
                    y: point.y * geo.size.height
                )
        } else {
            EmptyView()
        }
    }
}

#Preview(traits: .fixedLayout(width: 1000, height: 700)) {
    GameView()
}