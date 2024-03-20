//
//  GameVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 19.03.24.
//

import SwiftUI

enum GameMode: String, CaseIterable {
    case toFive = "Five"
    case toTen = "Ten"
}

@Observable
class GameVM {
    public var mode: GameMode = .toFive

    private(set) var searchedNumber = 0
    private(set) var searchedNumberInFramesCount = 0

    private(set) var correctAnswer = false
    private(set) var correctAnswerCount = 0

    init() {
        newSearchNumber()
        correctAnswerCount = UserDefaults.standard.integer(forKey: "CORRECT_ANSWER_COUNT_KEY")
    }

    func newFingerCount(_ count: Int) {
        if correctAnswer { return }

        if count == searchedNumber {
            searchedNumberInFramesCount += 1

            if searchedNumberInFramesCount < 4 { return }

            searchedNumberInFramesCount = 0
            correctAnswer = true
            correctAnswerCount += 1

            newSearchNumber()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.correctAnswer = false
            }
        }
    }

    func newSearchNumber() {
        let currentNumber = searchedNumber

        switch mode {
        case .toFive:
            searchedNumber = Int.random(in: 0 ... 5)
        case .toTen:
            searchedNumber = Int.random(in: 0 ... 10)
        }

        if currentNumber == searchedNumber {
            newSearchNumber()
        }
    }

    public func saveCount() {
        UserDefaults.standard.set(correctAnswerCount, forKey: "CORRECT_ANSWER_COUNT_KEY")
    }

    public func retrieveCount() {
        correctAnswerCount = UserDefaults.standard.integer(forKey: "CORRECT_ANSWER_COUNT_KEY")
    }
}
