//
//  IterationTimer.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Foundation

public struct IterationTimerUnit: Codable {
    public var uuid: UUID
    public var title: String
    public var category: TimerCategory
    public var startTime: Date
    public var endTime: Date
    public var duration: TimeInterval
    
    public init(uuid: UUID, title: String, category: TimerCategory, startTime: Date, endTime: Date, duration: TimeInterval) {
        self.uuid = uuid
        self.title = title
        self.category = category
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
    }
}

public extension IterationTimerUnit {
    func currentUnitCount(date: Date) -> Int {
        if duration == 0 { return 0 }
        return Int(date.timeIntervalSince(startTime) / duration)
    }

    var maxUnitCount: Int {
        if duration == 0 { return 0 }
        return Int(endTime.timeIntervalSince(startTime) / duration)
    }
}
