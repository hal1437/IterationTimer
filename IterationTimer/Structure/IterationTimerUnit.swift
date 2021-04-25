//
//  IterationTimer.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Foundation

struct IterationTimerUnit: Codable {
    var uuid: UUID
    var title: String
    var category: TimerCategory
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval
}
