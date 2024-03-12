//
//  ContentView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var cameraVM = CameraVM()
    @State private var mathVM = MathVM()

    var body: some View {
        VStack(spacing: 20) {
            CameraStreamView(cameraVM: cameraVM)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    FingersOverlay(handPoints: mathVM.points.filter { $0.isCounted })
                        .foregroundStyle(.indigo)

//                    FingersOverlay(handPoints: mathVM.points.filter { $0.isCounted == false })
//                        .foregroundStyle(.white)
                }
                .flipped(.horizontal)

            Group {
                if let fingerCount = mathVM.fingerCount {
                    Text(fingerCount.description)
                } else {
                    Text("No fingers shown")
                }
            }
            .font(.largeTitle)
        }
        .padding(20)
        .onAppear {
            cameraVM.setNewFrameCallback(callback: mathVM.newFrame)
        }
    }
}

#Preview {
    ContentView()
}
