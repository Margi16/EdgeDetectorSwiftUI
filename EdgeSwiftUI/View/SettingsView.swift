//
//  SettingsView.swift
//  EdgeSwiftUI
//
//  Created by Margi  Bhatt on 18/08/22.
//

import SwiftUI
import EdgeDetectorFramework

struct SettingsView: View {
    
    @AppStorage(Settings.minPivot.rawValue)
    private var minPivot = UserDefaults.standard.minPivot
    @AppStorage(Settings.maxPivot.rawValue)
    private var maxPivot = UserDefaults.standard.maxPivot
    @AppStorage(Settings.minAdjust.rawValue)
    private var minAdjust = UserDefaults.standard.minAdjust
    @AppStorage(Settings.maxAdjust.rawValue)
    private var maxAdjust = UserDefaults.standard.maxAdjust
    @AppStorage(Settings.epsilon.rawValue)
    private var eps = UserDefaults.standard.epsilon
    @AppStorage(Settings.iouThresh.rawValue)
    private var iouThresh = UserDefaults.standard.iouThresh
    
    var body: some View {
        Rectangle()
            .frame(width: 80, height: 2, alignment: .center)
            .padding()
            .cornerRadius(400)
        Form {
            Section(header: Text("Vision Request")) {
                Text("Min Contrast Pivot: \(String(format: "%.2f", minPivot))")
                Slider(value: $minPivot, in: 0.0...1.0, step: 0.05)
                
                Text("Max Contrast Pivot: \(String(format: "%.2f", maxPivot))")
                Slider(value: $maxPivot, in: 0.0...1.0, step: 0.05)
                
                Text("Min Contrast Adjustment: \(String(format: "%.1f", minAdjust))")
                Slider(value: $minAdjust, in: 0.0...3.0, step: 0.1)
                
                Text("Max Contrast Adjustment: \(String(format: "%.1f", maxAdjust))")
                Slider(value: $maxAdjust, in: 0.0...3.0, step: 0.1)
            }
            
            Section(header: Text("Simplicity")) {
                Text("Polygon Approximation Epsilon: \(String(format: "%.4f", eps))")
                Slider(value: $eps, in: 0.0001...0.01, step: 0.0001)
            }
            
            Section(header: Text("Filtering")) {
                Text("IoU Threshold: \(String(format: "%.3f", iouThresh))")
                Slider(value: $iouThresh, in: 0.05...0.95, step: 0.025)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
