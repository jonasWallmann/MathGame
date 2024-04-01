//
//  CameraStreamView.swift
// AVJ Math
//
//  Created by Jonas Wallmann on 27.02.24.
//


import SwiftUI

struct CameraStreamView: View {
    @Bindable var cameraVM: CameraVM

    let newFrameCallback: (CGImage) -> Void

    var body: some View {
        Group {
            if let cgImage = cameraVM.currentFrame {
                Image(cgImage, scale: 1, label: Text("Camera"))
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            cameraVM.newFrameCallback(newFrameCallback)
        }
    }
}

extension View {
    func flipped(_ axis: Axis? = .horizontal, anchor: UnitPoint = .center) -> some View {
        guard let axis = axis else {
            return scaleEffect(CGSize(width: 1, height: 1), anchor: anchor)
        }
        switch axis {
        case .horizontal:
            return scaleEffect(CGSize(width: -1, height: 1), anchor: anchor)
        case .vertical:
            return scaleEffect(CGSize(width: 1, height: -1), anchor: anchor)
        }
    }
}

#Preview {
    func newImage(img: CGImage) { }

    return CameraStreamView(cameraVM: CameraVM(), newFrameCallback: newImage)
}

