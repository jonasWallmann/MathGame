//
//  CountView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct CountView: View {
    @State public var vm: CountVM

    @State private var cameraVM = CameraVM()
    
    @Bindable public var fingerVM: FingerCountVM
    @Bindable public var cardVM: CardCountVM

    var body: some View {
        CameraStreamView(cameraVM: cameraVM)
//            .overlay {
//                if cardVM.cardsShown == false {
//                    FingersOverlay(handPoints: fingerVM.points.filter { $0.isCounted })
//                        .foregroundStyle(.indigo)
//                }
//            }
//            .overlay(alignment: .top) {
//                Text(vm.count?.description ?? "Nothing to count")
//                    .font(.largeTitle)
//                    .padding(.vertical, 8)
//                    .padding(.horizontal, 16)
//                    .frame(minWidth: 60)
//                    .background(.thinMaterial, in: .rect(cornerRadius: 8))
//                    .padding(.top, 16)
//            }
            .onAppear {
                cameraVM.newFrameCallback(newFrame)
            }
    }

    private func newFrame(frame: CGImage) {
        fingerVM.newFrame(frame)
//        cardVM.newFrame(frame)
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
    func newCount(count: Int) {

    }

    return CountView(vm: CountVM(newCountCallback: newCount), fingerVM: FingerCountVM(), cardVM: CardCountVM())
}
