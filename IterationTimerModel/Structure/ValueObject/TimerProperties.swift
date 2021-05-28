//
//  TimerProperties.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2021/05/29.
//

import Foundation

public struct TimerProperties {
    public var title: String
    public var category: TimerCategory
    public var maxStamina: Int
    public var duration: TimeInterval
    
    public init(title: String, category: TimerCategory, maxStamina: Int, duration: TimeInterval) throws {
        if maxStamina < 0 || duration < 0 { throw IterationTimerError.unexpectedInitialize }
        self.title = title
        self.category = category
        self.maxStamina = maxStamina
        self.duration = duration
    }
}
