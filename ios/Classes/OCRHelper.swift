import Foundation
import UIKit
import Vision

@objc class OCRHelper: NSObject {
    @objc static func recognizeText(from imagePath: String, completion: @escaping (String) -> Void)
    {
        guard let image = UIImage(contentsOfFile: imagePath),
            let cgImage = image.cgImage
        else {
            completion("")
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil
            else {
                completion("")
                return
            }
            let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")
            completion(recognizedText)
        }
        request.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            completion("")
        }
    }
}
