//
//  Measure.swift
//  PoseDetectionProto
//
//  Created by μ μμ on 2021/11/24.
//

import Foundation
import QuartzCore
import UIKit

protocol πDelegate {
    func updateMeasure(inferenceTime: Double, executionTime: Double, fps: Int)

}

class π {

    var delegate: πDelegate?

    var index: Int = -1
    var measurements: [Dictionary<String, Double>]

    init() {
        let measurement = [
            "start": CACurrentMediaTime(),
            "end": CACurrentMediaTime()
        ]
        measurements = Array<Dictionary<String, Double>>(repeating: measurement, count: 30)
    }

    //start
    func π¬π() {
        index += 1
        index %= 30
        measurements[index] = [:]

        π·(for: index, with: "start")

    }

    //stop
    func π¬π€() {
        π·(for: index, with: "end")

        let beforeMeasurement = getBeforeMeasurement(for: index)
        let currentMeasurement = measurements[index]
        if let startTime = currentMeasurement["start"],
           let endInferenceTime = currentMeasurement["endInference"],
           let endTime = currentMeasurement["end"],
           let beforeStartTime = beforeMeasurement["start"] {
            delegate?.updateMeasure(inferenceTime: endInferenceTime - startTime,
                                    executionTime: endTime - startTime,
                                    fps: Int(1/(startTime - beforeStartTime)))
        }
    }

    // labeling with
    func π·(with msg: String? = ""){
        π·(for: index, with: msg)

    }

    private func π·(for index: Int, with msg: String? = "") {
        if let message = msg {
            measurements[index][message] = CACurrentMediaTime()
        }
    }
    
    private func getBeforeMeasurement(for index: Int) -> Dictionary<String, Double> {
        return measurements[(index + 30 - 1) % 30]
    }
    
    // log
    func π¨() {
        
    }

    class MeasureLogView: UIView {
        let etimeLabel = UILabel(frame: .zero)
        let fpsLabel = UILabel(frame: .zero)
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder: ) has not been implemented")
        }
    }

}
