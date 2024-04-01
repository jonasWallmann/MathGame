//
//  BlumeView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 19.03.24.
//

import RiveRuntime
import SwiftUI

struct FlowerRiveView: View {
    @State private var rive = RiveViewModel(fileName: "flower", fit: .contain)

    let isOpen: Bool

    var color: String = ["violet", "green", "blue"].randomElement()!

    var body: some View {
        rive.view()
            .onChange(of: isOpen) { _, newIsOpen in
                rive.setInput("ist_geöffnet", value: newIsOpen)
            }
            .frame(width: 70, height: 70)
    }
}

#Preview {
    @State var isOpen = true

    return FlowerRiveView(isOpen: isOpen, color: "violet")
}
