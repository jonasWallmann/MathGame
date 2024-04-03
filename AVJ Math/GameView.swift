//
//  ContentView.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

struct GameView: View {
    @Bindable var gameVM: GameVM

    @State var fingerVM: FingerCountVM

    @State private var cameraVM = CameraVM()

    var body: some View {
        ZStack {
            GeometryReader { geo in
                ZStack {
                    CameraStreamView(cameraVM: cameraVM, newFrameCallback: fingerVM.newFrame)
                        .frame(maxHeight: .infinity)

                    ForEach(fingerVM.points, id: \.id) { finger in
                        FlowerView(isOpen: gameVM.flowersOpen, color: gameVM.flowerColor)
                            .position(
                                x: finger.point.x * geo.size.width,
                                y: finger.point.y * geo.size.height
                            )
                            .opacity(finger.isCounted ? 1 : 0)
                    }
                }
                .flipped(.horizontal)
            }

            // top bar
            HStack {
                Spacer()
                Text(gameVM.searchedNumber.description)
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(.vertical, 12)
//            .background(gameVM.searchColor.opacity(0.7))
            .background(.thinMaterial)
            .frame(maxHeight: .infinity, alignment: .top)

            // bottom bar
            MeadowView(count: gameVM.correctAnswerCount)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .toolbar {
            HStack {
                Text("Fingers")
                Picker("Game mode", selection: $gameVM.mode) {
                    ForEach(GameMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
            }

            HStack {
                Text("Frames")
                Picker("Frames", selection: $gameVM.rightNumberInFramesBeforeSuccessCount) {
                    ForEach(1 ..< 20) { frames in
                        Text(frames.description).tag(frames)
                    }
                }
            }
            .padding(.leading, 32)
        }
        .onAppear(perform: gameVM.retrieveCount)
        .onDisappear(perform: gameVM.saveCount)
    }
}

#Preview(traits: .fixedLayout(width: 500, height: 350)) {
    func newCount(count _: Int) {}

    return GameView(gameVM: GameVM(), fingerVM: FingerCountVM(newCountCallback: newCount))
}
