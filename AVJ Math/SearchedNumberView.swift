//
//  SearchedNumberView.swift
//  AVJ Math
//
//  Created by Viola Kempa on 09.04.24.
//

import SwiftUI

struct SearchedNumberView: View {
    let gameMode: GameMode
    
    let searchedNumber: Int
    let shownNumber: Int
    
    private var upperNumber: Int {
        if gameMode == .toFive {
            return 5
        }
        return 10
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< upperNumber, id: \.self) { num in
                Text(num.description)
            }
        }
    }
}

#Preview {
    SearchedNumberView(gameMode: .toTen, searchedNumber: 3, shownNumber: 7)
}
