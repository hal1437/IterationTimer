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
