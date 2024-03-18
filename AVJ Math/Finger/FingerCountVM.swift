//
//  MathVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 27.02.24.
//

import Vision

@Observable
class FingerCountVM {
    public var count = 0
    public var frameCount = 0

    public var points = [FingerPoint]()

    public func newFrame(_ frame: CGImage) {
        frameCount += 1
        if frameCount % 10 == 0  { return }

        DispatchQueue.global(qos: .default).async {
            let analytics = self.analyse(frame: frame)

            DispatchQueue.main.async {
                self.count = analytics.fingerCount
                self.points = analytics.points
            }
        }
    }

    private func analyse(frame: CGImage) -> (fingerCount: Int, points: [FingerPoint]) {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 4

        let handler = VNImageRequestHandler(cgImage: frame)

        var fingerCount = 0
        var points = [FingerPoint]()

        do {
            try handler.perform([request])

            guard let results = request.results else { return (0, []) }

            for observation in results {
                // thumb
                let wrist = try observation.recognizedPoint(.wrist)
                let thumbCMC = try observation.recognizedPoint(.thumbCMC)
                let unit = thumbCMC.distance(wrist) * 0.2

                let thumbMP = try observation.recognizedPoint(.thumbMP)
                let thumbTip = try observation.recognizedPoint(.thumbTip)

                let thumbUp = thumbMP.x < wrist.x ? thumbMP.x > thumbTip.x - unit : thumbMP.x < thumbTip.x + unit

                // index
                let indexPip = try observation.recognizedPoint(.indexPIP)
                let indexTip = try observation.recognizedPoint(.indexTip)

                let indexUp = indexPip.y < indexTip.y

                // middle
                let middlePip = try observation.recognizedPoint(.middlePIP)
                let middleTip = try observation.recognizedPoint(.middleTip)

                let middleUp = middlePip.y < middleTip.y

                // ring
                let ringPip = try observation.recognizedPoint(.ringPIP)
                let ringTip = try observation.recognizedPoint(.ringTip)

                let ringUp = ringPip.y < ringTip.y

                // little
                let littlePip = try observation.recognizedPoint(.littlePIP)
                let littleTip = try observation.recognizedPoint(.littleTip)

                let littleUp = littlePip.y < littleTip.y

                fingerCount += (thumbUp ? 1 : 0) + (indexUp ? 1 : 0) + (middleUp ? 1 : 0) + (ringUp ? 1 : 0) + (littleUp ? 1 : 0)

                points.append(FingerPoint(isCounted: thumbUp, point: thumbTip))
                points.append(FingerPoint(isCounted: indexUp, point: indexTip))
                points.append(FingerPoint(isCounted: middleUp, point: middleTip))
                points.append(FingerPoint(isCounted: ringUp, point: ringTip))
                points.append(FingerPoint(isCounted: littleUp, point: littleTip))
            }

            return (fingerCount, points)

        } catch {
            print(error)
        }
        return (0, [])
    }
}

struct FingerPoint: Identifiable {
    let id = UUID()

    let isCounted: Bool
    let point: CGPoint

    init(isCounted: Bool, point: CGPoint) {
        self.isCounted = isCounted
        self.point = point
    }

    init(isCounted: Bool, point: VNRecognizedPoint) {
        self.isCounted = isCounted
        self.point = CGPoint(x: point.x, y: abs(1 - point.y))
    }
}