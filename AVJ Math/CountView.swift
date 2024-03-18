//
//  CountView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct CountView: View {
    @State private var vm = CountVM()

    @State private var cameraVM = CameraVM()
    @State private var fingerVM = FingerCountVM()
    @State private var cardVM = CardCountVM()

    var body: some View {
        VStack(spacing: 20) {
            CameraStreamView(cameraVM: cameraVM)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    if cardVM.count == 0 {
                        FingersOverlay(handPoints: fingerVM.points.filter { $0.isCounted })
                            .foregroundStyle(.indigo)

//                        FingersOverlay(handPoints: fingerVM.points.filter { $0.isCounted == false })
//                            .foregroundStyle(.white)
                    }
                }
            #if os(macOS)
//                .flipped(.horizontal)
            #endif

//            debug

            Text(vm.count?.description ?? "Nothing to count")
                .font(.largeTitle)
        }
        .padding(20)
        .onAppear {
            cameraVM.newFrameCallback(newFrame)
        }
    }

    private func newFrame(frame: CGImage) {
        fingerVM.newFrame(frame)
        cardVM.newFrame(frame)
        vm.newCount(fingers: fingerVM.count, cards: cardVM.count)
    }

    private var debug: some View {
        HStack(spacing: 60) {
            Text("\(fingerVM.count.description) Fingers")
            Text("\(cardVM.count.description) Cards")
        }
        .font(.title2)
    }
}

#Preview {
    CountView()
}
