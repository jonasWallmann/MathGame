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

    public func newCount(fingers: Int, cards: Int) {
        if cards == 0 {
            count = fingers
        } else {
            count = cards
        }
    }
}
