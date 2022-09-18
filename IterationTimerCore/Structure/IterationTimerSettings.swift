//
//  IterationTimerSettings.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2022/09/12.
//

import Foundation

public struct IterationTimerSettings: Equatable, Codable {
    public var title: String
    public var category: TimerCategory
    public var maxStamina: Int
    public var divideStamina: Int
    public var duration: TimeInterval
    public var notification: IterationTimerNotificationTrigger
    
    public init(title: String, category: TimerCategory, maxStamina: Int, divideStamina: Int, duration: TimeInterval, notification: IterationTimerNotificationTrigger) throws {
        if maxStamina <= 0 || duration <= 0 { throw IterationTimerError.unexpectedInitialize }
        self.title = title
        self.category = category
        self.maxStamina = maxStamina
        self.divideStamina = divideStamina
        self.duration = duration
        self.notification = notification
    }
}
