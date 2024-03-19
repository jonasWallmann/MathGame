//
//  GameVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 19.03.24.
//

import Foundation

@Observable
class GameVM {
    private(set) var searchedNumber: Int = 0

    private(set) var correctAnswer: Bool = false

    init() {
        newSearchNumber()
    }

    func newFingerCount(_ count: Int) {
        if count == searchedNumber {
            correctAnswer = true
            newSearchNumber()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.correctAnswer = false
            }
        }
    }

    func newSearchNumber() {
        searchedNumber = Int.random(in: 0 ... 10)
    }
}
