//
//  ContourDetector.swift
//  EdgeSwiftUI
//
//  Created by Margi  Bhatt on 18/08/22.
//

import Vision

public class ContourDetector {
    
    public static let shared = ContourDetector()
    
    private var epsilon: Float = 0.001
    
    private init() { }
    
    private lazy var request: VNDetectContoursRequest = {
        let req = VNDetectContoursRequest()
        return req
    }()
    
    private func perform(request: VNRequest, on image: CGImage) throws -> VNRequest {
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        
        try requestHandler.perform([request])
        
        return request
    }
    
    private func postProcess(request: VNRequest) -> [Contour] {
        guard let results = request.results as? [VNContoursObservation] else {
            return []
        }
        
        let vnContours = results.flatMap { contour in
            (0..<contour.contourCount).compactMap { try? contour.contour(at: $0) }
        }
        
        let simplifiedContours = vnContours.compactMap {
            try? $0.polygonApproximation(epsilon: self.epsilon)
        }
        
        return simplifiedContours.map { Contour(vnContour: $0) }
    }
    
    public func process(image: CGImage?) throws -> [Contour] {
        guard let image = image else {
            return []
        }
        
        let contourRequest = try perform(request: request, on: image)
        return postProcess(request: contourRequest)
    }
    
    public func set(contrastPivot: CGFloat?) {
        request.contrastPivot = contrastPivot.map {
            NSNumber(value: $0)
        }
    }
    
    public func set(contrastAdjustment: CGFloat) {
        request.contrastAdjustment = Float(contrastAdjustment)
    }
    
    public func set(epsilon: CGFloat) {
      self.epsilon = Float(epsilon)
    }
}
