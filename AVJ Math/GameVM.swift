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
    public var mode: GameMode = .toTen

    private(set) var searchedNumber = 1

    private(set) var correctAnswer = false
    private(set) var correctAnswerCount = 0

    private(set) var flowersOpen = true

    private(set) var flowerColor: Color = .leave
    private let colors: [Color] = [.black, .pink, .red, .green, .blue, .purple, .cyan, .indigo, .orange, .mint, .teal]

    public var rightNumberInFramesBeforeSuccessCount = 3
    private var rightNumberInFramesCount = 0

    public var searchColor: Color {
        colors[searchedNumber]
    }

    init() {
        newSearchNumber()
//        correctAnswerCount = UserDefaults.standard.integer(forKey: "CORRECT_ANSWER_COUNT_KEY")
    }

    func newFingerCount(_ count: Int) {
//        if count < colors.count {
//            flowerColor = colors[count]
//        } else {
//            flowerColor = .white
//        }

        if count != searchedNumber { return }

        rightNumberInFramesCount += 1

        if rightNumberInFramesBeforeSuccessCount > rightNumberInFramesCount { return }

        correctAnswer = true
        rightNumberInFramesCount = 0

        if correctAnswer {
            correctAnswerCount += 1
            newSearchNumber()

            var newPossibleColors = colors
            newPossibleColors.removeAll(where: { $0 == flowerColor })

//            withAnimation(.easeInOut(duration: 0.7)) {
                flowersOpen = true
//            }

            let currentCorrectAnswerCount = correctAnswerCount
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                if currentCorrectAnswerCount == self.correctAnswerCount {
//                    withAnimation(.easeInOut(duration: 1.5)) {
//                        self.flowersOpen = false
//                    }
                }
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
//        correctAnswerCount = UserDefaults.standard.integer(forKey: "CORRECT_ANSWER_COUNT_KEY")
    }
}
