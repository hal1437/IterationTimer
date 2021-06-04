//
//  IterationTimer.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Foundation

public struct IterationTimer: Codable, Identifiable {
    private (set) public var id: UUID
    public var settings: IterationTimerSettings
    
    private var startTime: Date
    private var endTime: Date

    public init(currentStamina: Int, settings: IterationTimerSettings, since date: Date) {
        self.id = UUID()
        self.settings = settings
        self.startTime = Date(timeInterval: TimeInterval(Double(-currentStamina) * settings.duration), since: date)
        self.endTime = Date(timeInterval: TimeInterval(Double(settings.maxStamina) * settings.duration), since: startTime)
    }
    
    /// 現在のスタミナ
    public func currentStamina(date: Date) -> Int {
        return Int(date.timeIntervalSince(startTime) / settings.duration)
    }

    /// スタミナが1つ回復するまでの秒数
    public func remainingOne(date: Date) -> TimeInterval {
        let delta = endTime.timeIntervalSince(startTime)
        let perTime = Int(delta) / settings.maxStamina
        let currentInterval = endTime.timeIntervalSince(date)
        let remainingOne = TimeInterval(Int(currentInterval) % perTime)
        return remainingOne == 0 ? TimeInterval(perTime) : remainingOne
    }

    /// スタミナが全て回復するまでの秒数
    public func remainingFull(date: Date) -> TimeInterval {
        return endTime.timeIntervalSince(date)
    }
}
