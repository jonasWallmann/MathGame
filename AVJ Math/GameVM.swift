//
//  GameVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 19.03.24.
//

import Foundation

@Observable
class GameVM {
    private(set) var searchedNumber = 0

    private(set) var correctAnswer = false
    private(set) var correctAnswerCount = 0

    init() {
        newSearchNumber()
    }

    func newFingerCount(_ count: Int) {
        if count == searchedNumber {
            correctAnswer = true
            correctAnswerCount += 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.newSearchNumber()
                self.correctAnswer = false
            }
        }
    }

    func newSearchNumber() {
        searchedNumber = Int.random(in: 0 ... 10)
    }
}
