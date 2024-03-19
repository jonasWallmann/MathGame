//
//  CountVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import Foundation

@Observable
class CountVM {
    private(set) var count: Int?

    private var newCountCallback: (Int) -> Void

    init(newCountCallback: @escaping (Int) -> Void) {
        self.newCountCallback = newCountCallback
    }

    public func newCount(fingers: Int, cards: Int) {
        if cards == 0 {
            count = fingers
        } else {
            count = cards
        }
        
        if let count = count {
            newCountCallback(count)
        }
    }
}
