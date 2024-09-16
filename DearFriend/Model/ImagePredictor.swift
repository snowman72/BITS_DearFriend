//
//  ImagePredictor.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 13/8/24.
//

import Vision
import UIKit

class ImagePredictor {
    private static let imageClassifier = createImageClassifier()
    
    struct Prediction {
        let classification: String
        let confidencePercentage: String
    }
    
    typealias ImagePredictionHandler = (_ predictions: [Prediction]?) -> Void
    
    private static func createImageClassifier() -> VNCoreMLModel {
        let defaultConfig = MLModelConfiguration()
        
        guard let imageClassifier = try? MobileNet(configuration: defaultConfig).model,
              let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifier) else {
            fatalError("Failed to create image classifier")
        }
        
        return imageClassifierVisionModel
    }
    
    func makePredictions(for photo: UIImage, completionHandler: @escaping ImagePredictionHandler) throws {
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        
        guard let photoImage = photo.cgImage else {
            throw NSError(domain: "ImagePredictor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get CGImage from UIImage"])
        }
        
        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        let request = createImageClassificationRequest(completionHandler: completionHandler)
        
        try handler.perform([request])
    }
    
    private func createImageClassificationRequest(completionHandler: @escaping ImagePredictionHandler) -> VNRequest {
        let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.imageClassifier) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                completionHandler(nil)
                return
            }
            
            let predictions = results.map { observation in
                Prediction(classification: observation.identifier,
                           confidencePercentage: String(format: "%.2f", observation.confidence * 100))
            }
            
            completionHandler(predictions)
        }
        
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
            switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
            @unknown default: self = .up
            }
        }
}
