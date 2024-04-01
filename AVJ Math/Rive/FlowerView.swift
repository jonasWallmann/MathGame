//
//  FlowerShape.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 31.03.24.
//

import SwiftUI

struct FlowerView: View {
    let isOpen: Bool

    let color: Color

    var body: some View {
        ZStack {
            ForEach(0 ..< 6) { i in
                LeaveView(isOpen: isOpen, color: color)
                    .rotationEffect(.degrees(Double(i) * 30))
            }

            FlowerOvuleView()
                .frame(width: 20, height: 20)
        }
    }
}

struct LeaveView: View {
    let isOpen: Bool

    let color: Color

    var body: some View {
        Ellipse()
            .foregroundStyle(color)
            .frame(maxWidth: isOpen ? 15 : 0, maxHeight: isOpen ? 40 : 0)
            .opacity(0.7)
    }
}

struct TestView: View {
    @State var isOpen = false

    var body: some View {
        VStack {
            Button("Toggle") {
                withAnimation(.easeInOut(duration: 1)) {
                    isOpen.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.isOpen = true
                    }
                }
            }
            .padding()

            FlowerView(isOpen: isOpen, color: .orange)
                .frame(width: 400, height: 400)
                .padding()

            Text(isOpen.description)
                .padding()
        }
    }
}

#Preview("Test") {
    TestView()
}

#Preview("Flower") {
    FlowerView(isOpen: true, color: .orange)
        .frame(width: 400, height: 400)
}

#Preview("Leave") {
    LeaveView(isOpen: true, color: .pink)
}
