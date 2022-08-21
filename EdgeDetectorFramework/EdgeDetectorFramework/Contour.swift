//
//  Contour.swift
//  EdgeSwiftUI
//
//  Created by Margi  Bhatt on 18/08/22.
//

import Vision

public struct Contour: Identifiable, Hashable {
    public let id = UUID()
    let area: Double
    
    private let vnContour: VNContour
    
    init(vnContour: VNContour) {
        self.vnContour = vnContour
        self.area = vnContour.boundingBox.area
    }
    
    var normalizedPath: CGPath {
        self.vnContour.normalizedPath
    }
    
    var aspectRatio: CGFloat {
        CGFloat(self.vnContour.aspectRatio)
    }
    
    var boundingBox: CGRect {
        self.vnContour.boundingBox
    }
    
    public func intersectionOverUnion(with contour: Contour) -> CGFloat {
        let intersection = boundingBox.intersection(contour.boundingBox).area
        let union = area + contour.area - intersection
        return CGFloat(intersection / union)
    }
}
