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

    @State private var openSpots = Array(1 ... 17)

    var body: some View {
        rive.view()
            .onChange(of: count) { _, _ in
                guard let openSpot = openSpots.randomElement() else { return }

                rive.setInput("Number 1", value: Double(openSpot))

                openSpots.removeAll(where: { $0 == openSpot })
            }
    }
}

#Preview {
    MeadowView(count: 5)
}
