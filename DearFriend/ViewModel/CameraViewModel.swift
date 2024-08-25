//
//  CameraViewModel.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 22/8/24.
//

import AVFoundation
import Vision
import UIKit
import SwiftUI

class CameraViewModel: NSObject, ObservableObject {
    enum RecognitionMode {
        case object
        case text
    }
    
    @Published var identifiedObject: String = "Scanning..."
    @Published var recognizedText: String = "Scanning for text..."
    @Published var errorMessage: String?
    @Published var currentMode: RecognitionMode
    
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let captureOutput = AVCaptureVideoDataOutput()
    private var imagePredictor = ImagePredictor()
    private let synthesizer = AVSpeechSynthesizer()
    private var lastSpokenObject: String?
    
    private var textRecognizer = TextRecognizer()

    private var lastSpokenText: String?
    private var lastTextRecognitionTime: Date = Date()
    private let textRecognitionInterval: TimeInterval = 0.5 // 0.5 second interval for text recognition
    
    private var lastPredictionTime: Date = Date()
    private let predictionInterval: TimeInterval = 1.0 // 1 second interval
    
    
    init(initialMode: RecognitionMode) {
        self.currentMode = initialMode
        self.imagePredictor = ImagePredictor()
        super.init()
        DispatchQueue.main.async {
            self.checkCameraAuthorization()
        }
    }
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.setupCaptureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                } else {
                    DispatchQueue.main.async {
                        self.updateUI(object: "Error: Camera access is required for this app to function.")
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.updateUI(object: "Error: Camera access is required. Please enable it in Settings.")
            }
        @unknown default:
            DispatchQueue.main.async {
                self.updateUI(object: "Error: Unknown camera authorization status.")
            }
        }
    }
    
    private func setupCaptureSession() {
        sessionQueue.async {
            if !self.session.isRunning {
                // Restart the session
                self.session.startRunning()
            }
            
            self.session.beginConfiguration()
            
            // Add video input
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                self.updateUI(object: "Error: Unable to access the back camera.")
                self.session.commitConfiguration()
                return
            }
                    
            do {
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                guard self.session.canAddInput(videoDeviceInput) else {
                    self.updateUI(object: "Error: Unable to add video device input to the session.")
                    self.session.commitConfiguration()
                    return
                }
                self.session.addInput(videoDeviceInput)
            } catch {
                self.updateUI(object: "Error: Unable to create video device input: \(error.localizedDescription)")
                self.session.commitConfiguration()
                return
            }
            
            
            
            // Add video output
            self.captureOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
            guard self.session.canAddOutput(self.captureOutput) else {
                self.updateUI(object: "Error: Unable to add video output to the session.")
                self.session.commitConfiguration()
                return
            }
            self.session.addOutput(self.captureOutput)
            
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
    
    private func updateUI(object: String) {
        DispatchQueue.main.async {
            self.identifiedObject = object
        }
    }
    
    private func speakIdentifiedObject(_ object: String) {
        DispatchQueue.main.async {
            // Only speak if the object is different from the last spoken object
            guard object != self.lastSpokenObject else { return }
            
            let utterance = AVSpeechUtterance(string: object)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            
            self.synthesizer.speak(utterance)
            self.lastSpokenObject = object
        }
    }
    
    private func speakRecognizedText(_ text: String) {
        // Only speak if the text is different from the last spoken text
        guard text != lastSpokenText else { return }
        
        DispatchQueue.main.async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            
            self.synthesizer.speak(utterance)
            self.lastSpokenText = text
        }
    }
    
    private func shouldPerformTextRecognition() -> Bool {
        let currentTime = Date()
        if currentTime.timeIntervalSince(lastTextRecognitionTime) >= textRecognitionInterval {
            lastTextRecognitionTime = currentTime
            return true
        }
        return false
    }
    
    private func shouldMakePrediction() -> Bool {
        let currentTime = Date()
        if currentTime.timeIntervalSince(lastPredictionTime) >= predictionInterval {
            lastPredictionTime = currentTime
            return true
        }
        return false
    }
    
    func stopAllProcesses() {
        synthesizer.stopSpeaking(at: .immediate)
        session.stopRunning()
        identifiedObject = "Scanning..."
        recognizedText = "Scanning for text..."
        lastSpokenObject = nil
        lastSpokenText = nil
    }
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                self.updateUI(object: "Error: Unable to get image from sample buffer.")
                return
            }
            
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                self.updateUI(object: "Error: Unable to create CGImage from CIImage.")
                return
            }
            
            let image = UIImage(cgImage: cgImage)
            
            switch self.currentMode {
            case .object:
                if self.shouldMakePrediction() {
                    self.performObjectRecognition(on: image)
                }
            case .text:
                if self.shouldPerformTextRecognition() {
                    self.performTextRecognition(on: pixelBuffer)
                }
            }
        }
    }
    
    private func performTextRecognition(on pixelBuffer: CVPixelBuffer) {
        let orientation = CGImagePropertyOrientation.up // Adjust if needed based on camera orientation

        textRecognizer.recognizeText(in: pixelBuffer, orientation: orientation) { recognizedText in
            DispatchQueue.main.async {
                if let text = recognizedText, !text.isEmpty {
                    self.recognizedText = text
                    self.speakRecognizedText(text)
                } else {
                    self.recognizedText = "No text detected"
                }
            }
        }
    }
    
    private func performObjectRecognition(on image: UIImage) {
        // Update UI immediately to show we're scanning
        updateUI(object: "Scanning...")
        
        // Perform the prediction on a background queue
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.imagePredictor.makePredictions(for: image) { predictions in
                    DispatchQueue.main.async {
                        if let topPrediction = predictions?.first {
                            let identifiedObject = topPrediction.classification
                            self.identifiedObject = "\(topPrediction.classification) - \(topPrediction.confidencePercentage)%"
                            self.updateUI(object: identifiedObject)
                            self.speakIdentifiedObject(identifiedObject)
                            
                        } else {
                            self.identifiedObject = "No object detected"
                            self.updateUI(object: "No object detected")
                        }
                    }
                }
            } catch {
                self.updateUI(object: "Error: \(error.localizedDescription)")
            }
        }
    }
}
