//
//  IterationTimer.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Foundation
import IterationTimerCore

public extension IterationTimer {
    /// 現在のスタミナ
    func currentStamina(date: Date) -> Int {
        let currentStamina = Int(date.timeIntervalSince(startTime) / settings.duration)
        return currentStamina > settings.maxStamina ? settings.maxStamina : currentStamina
    }

    /// スタミナが1つ回復するまでの秒数
    func remainingOne(date: Date) -> TimeInterval {
        let delta = endTime.timeIntervalSince(startTime)
        let perTime = Int(delta) / settings.maxStamina
        let currentInterval = endTime.timeIntervalSince(date)
        let remainingOne = TimeInterval(Int(currentInterval) % perTime)
        return remainingOne == 0 ? TimeInterval(perTime) : remainingOne
    }

    /// スタミナが全て回復するまでの秒数
    func remainingFull(date: Date) -> TimeInterval {
        return endTime.timeIntervalSince(date)
    }
    
    /// 次の通知を行う時刻
    func nextNotifyDate() -> Date {
        switch self.settings.notification {
        case .never: return Date.init(timeIntervalSince1970: 0)
        case .on(let stamina): return startTime + TimeInterval(stamina * Int(settings.duration))
        case .completion(let before): return endTime - before
        }
    }
}
