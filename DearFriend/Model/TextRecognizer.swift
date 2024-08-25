//
//  TextRecognizer.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 25/8/24.
//

import Foundation
import Vision
import UIKit

class TextRecognizer {
    private let textRecognitionRequest: VNRecognizeTextRequest
    private let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)

    typealias TextRecognitionHandler = (_ recognizedText: String?) -> Void

    init() {
        textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate 
//        textRecognitionRequest.usesLanguageCorrection = false // Disable for faster processing
    }

    func recognizeText(in image: CVPixelBuffer, orientation: CGImagePropertyOrientation, completionHandler: @escaping TextRecognitionHandler) {
        let requestHandler = VNImageRequestHandler(ciImage: CIImage(cvPixelBuffer: image), orientation: orientation)
        
        textRecognitionWorkQueue.async {
            do {
                try requestHandler.perform([self.textRecognitionRequest])
                guard let observations = self.textRecognitionRequest.results else {
                    completionHandler(nil)
                    return
                }

                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }

                let recognizedText = recognizedStrings.joined(separator: " ")
                completionHandler(recognizedText)
            } catch {
                print("Failed to perform text recognition: \(error)")
                completionHandler(nil)
            }
        }
    }
}
