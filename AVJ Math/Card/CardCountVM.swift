//
//  CardCountVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 12.03.24.
//

import Vision

@Observable
class CardCountVM {
    public var count = 0
    public var frameCount = 0

    public var cardsShown: Bool {
        count != 0
    }

    public func newFrame(_ frame: CGImage) {
        frameCount += 1
        if frameCount % 10 == 0 { return }

//        DispatchQueue.global(qos: .utility) {
            self.analyse(frame: frame)
            //        analyseNumbers(frame: frame)
//        }
    }

    // MARK: Detect from barcode

    private func analyse(frame: CGImage) {
        let handler = VNImageRequestHandler(cgImage: frame)
        let request = VNDetectBarcodesRequest()

        do {
            try handler.perform([request])

            guard let results = request.results else { return }

            let codes = results.compactMap { $0.payloadStringValue }

            processResults(codes)
        } catch {
            print(error)
        }
    }

    // MARK: Detect from number

    private func analyseNumbers(frame: CGImage) {
        let handler = VNImageRequestHandler(cgImage: frame)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.minimumTextHeight = 1

        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

    func recognizeTextHandler(request: VNRequest, error _: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

        let recognizedStrings = observations.compactMap { observation in
            let chars = observation.topCandidates(7).map { $0.string }
            return chars.joined()
        }
        processResults(recognizedStrings)
    }

    private func processResults(_ results: [String]) {
        let numbers = results.map { $0.filter("0123456789.".contains) }

//        DispatchQueue.global() {
            self.count = numbers.reduce(0) { $0 + (Int($1) ?? 0) }
//        }
    }
}
