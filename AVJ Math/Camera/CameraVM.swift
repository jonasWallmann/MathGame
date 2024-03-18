//
//  CameraVM.swift
//  AVJ Math
//
//  Created by Jonas Wallmann on 27.02.24.
//

import AVFoundation
import CoreImage

@Observable
class CameraVM: NSObject {
    var currentFrame: CGImage?

    private var permissionGranted = false
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()

    private var newFrameCallback: ((CGImage) -> Void)? = nil

    override init() {
        super.init()
        checkPermission()
        sessionQueue.async { [weak self] in
            self?.setupCaptureSession()
            self?.captureSession.startRunning()
        }
    }

    func newFrameCallback(_ callback: @escaping (CGImage) -> Void) {
        newFrameCallback = callback
    }

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            permissionGranted = true

        case .notDetermined:
            requestPermission()

        default:
            permissionGranted = false
        }
    }

    func requestPermission() {
        // Strong reference not a problem here but might become one in the future.
        AVCaptureDevice.requestAccess(for: .video) { granted in
            self.permissionGranted = granted

            if granted {
                self.setupCaptureSession()
            }
        }
    }

    func setupCaptureSession() {
        let videoOutput = AVCaptureVideoDataOutput()

        guard permissionGranted else { return }

        guard
            let videoDevice = getVideoDevice(),
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
            captureSession.canAddInput(videoDeviceInput)
        else { return }

        captureSession.addInput(videoDeviceInput)

        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)

//        videoOutput.connection(with: .video)?.videoRotationAngle = 0
    }

    private func getVideoDevice() -> AVCaptureDevice? {
        #if os(macOS)
        if let main = AVCaptureDevice.default(for: .video) {
            return main
        }
        #endif

        #if os(iOS)
        if let wide = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            return wide
        }

        if let dual = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front) {
            return dual
        }
        if let dualWide = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .front) {
            return dualWide
        }
        if let ultraWide = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .front) {
            return ultraWide
        }
        #endif
        return nil
    }
}

extension CameraVM: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from _: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }

        DispatchQueue.main.async { [weak self] in
            self?.currentFrame = cgImage
        }

        if let newFrameCallback = newFrameCallback {
            newFrameCallback(cgImage)
        }
    }

    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }

        return cgImage
    }
}
