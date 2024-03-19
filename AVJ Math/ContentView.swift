//
//  ContentView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var gameVM = GameVM()

    @State private var fingerVM = FingerCountVM()
    @State private var cardVM = CardCountVM()

    var body: some View {
        Text("Show \(gameVM.searchedNumber.description)")

        Text(gameVM.correctAnswer ? "Correct" : "False")

        CountView(
            vm: CountVM(newCountCallback: gameVM.newFingerCount),
            fingerVM: fingerVM,
            cardVM: cardVM
        )
        .overlay {
            FingersOverlay(handPoints: fingerVM.points.filter { $0.isCounted })
        }
        .flipped(.horizontal)
    }
}

#Preview(traits: .fixedLayout(width: 1000, height: 700)) {
    ContentView()
}
