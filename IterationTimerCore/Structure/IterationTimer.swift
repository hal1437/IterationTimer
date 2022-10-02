//
//  IterationTimer.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2022/09/12.
//

import Foundation

public struct IterationTimer: Codable, Identifiable {
    private (set) public var id: UUID
    private (set) public var settings: IterationTimerSettings
    private (set) public var startTime: Date
    private (set) public var endTime: Date

    public init(currentStamina: Int, settings: IterationTimerSettings, since date: Date) {
        self.id = UUID()
        self.settings = settings
        self.startTime = Date(timeInterval: TimeInterval(Double(-currentStamina) * settings.duration), since: date)
        self.endTime = Date(timeInterval: TimeInterval(Double(settings.maxStamina) * settings.duration), since: startTime)
    }
}
