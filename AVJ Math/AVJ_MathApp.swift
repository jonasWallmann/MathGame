//
//  AVJ_MathApp.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import SwiftUI

@main
struct AVJ_MathApp: App {
    @State private var gameVM = GameVM()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameView(gameVM: gameVM, fingerVM: FingerCountVM(newCountCallback: gameVM.newFingerCount))
            }
        }
    }
}
