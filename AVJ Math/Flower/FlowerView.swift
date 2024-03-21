//
//  BlumeView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 19.03.24.
//

import RiveRuntime
import SwiftUI

struct FlowerView: View {
    @State private var rive = RiveViewModel(fileName: "flowernew", fit: .contain)

    @State var isOpen: Bool

    var color: String = ["violet", "green", "blue"].randomElement()!

    var body: some View {
        rive.view()
            .scaleEffect(0.03)
            .onChange(of: isOpen) { _, newValue in
                if newValue {
                    rive.triggerInput("Blume_auf_\(color)")
                }
            }
    }
}

#Preview {
    FlowerView(isOpen: false, color: "violet")
        .padding()
}
