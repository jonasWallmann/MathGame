//
//  MeadowView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 31.03.24.
//

import RiveRuntime
import SwiftUI

struct MeadowView: View {
    @State private var rive = RiveViewModel(fileName: "meadow", fit: .fill)

    let count: Int

    @State private var openSpots = Array(0 ... 88)

    var body: some View {
        rive.view()
            .onChange(of: count) { _, _ in
                addFlower()
            }
            .onAppear {
                initialFlowers()
            }
    }

    private func addFlower() {
        guard let openSpot = openSpots.randomElement() else { return }

        rive.setInput("Number 1", value: Double(openSpot))

        openSpots.removeAll(where: { $0 == openSpot })
    }

    private func initialFlowers() {
        for i in 0 ..< count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / 50) {
                self.addFlower()
            }
        }
    }
}

#Preview {
    MeadowView(count: 88)
}
