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
        ZStack {
            GeometryReader { geo in
                ZStack {
                    CountView(
                        vm: CountVM(newCountCallback: gameVM.newFingerCount),
                        fingerVM: fingerVM,
                        cardVM: cardVM
                    )

                    ForEach(fingerVM.points, id: \.id) { finger in
                        if finger.isCounted {
                            FlowerView(isOpen: gameVM.correctAnswer, color: "violet")
                                .position(
                                    x: finger.point.x * geo.size.width,
                                    y: finger.point.y * geo.size.height
                                )
                        }
                    }
                }
                .flipped(.horizontal)
            }

            // top bar
            HStack {
                Spacer()
                Text(gameVM.searchedNumber.description)
                    .font(.largeTitle)
                Spacer()
            }
            .frame(height: 60)
            .background(.thinMaterial)
            .frame(maxHeight: .infinity, alignment: .top)

            // bottom bar
            HStack {
                Spacer()
                Text("\(gameVM.correctAnswerCount) ✅")
                    .padding(.trailing, 20)
            }
            .frame(height: 100)
            .background(.brown)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .toolbar {
            Picker("Game mode", selection: $gameVM.mode) {
                ForEach(GameMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
        }
        .onAppear(perform: gameVM.retrieveCount)
        .onDisappear(perform: gameVM.saveCount)
    }
}


#Preview(traits: .fixedLayout(width: 500, height: 350)) {
    GameView()
}
