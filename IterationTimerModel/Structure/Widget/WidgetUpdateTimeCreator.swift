//
//  WidgetUpdateTimeCreator.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2022/10/09.
//

import Foundation

// Widgetのタイムラインの更新時間を返却する。

public struct WidgetUpdateTimeCreator {
    let repository: IterationTimerRepositoryProtocol
    
    public init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
    }
    
    public func create(currentDate: Date) -> [Date] {
        let timers = repository.getTimers
        let continuousTimers = repository.getTimers.filter { currentDate < $0.endTime } // まだ回復していないタイマー
        
        guard !timers.isEmpty,
              !continuousTimers.isEmpty else {
            return [currentDate]
        }
        
        // 定期更新タイマー
        let periodicallyUpdate = (1 ... 8).map { $0 * 15 } .map {
            Calendar.current.date(byAdding: .minute, value: $0, to: currentDate)!
        }
        
        // 定期更新タイマーから一定のルールで取り除く
        let continuousTimersLastUpdate = continuousTimers.max(by: { $0.endTime < $1.endTime })!.endTime
        let removedPeriodicallyUpdate = periodicallyUpdate
            .filter { period in continuousTimers.allSatisfy { continuous in !period.isRange(minute: 15, of: continuous.endTime) } }
            .filter { period in period < continuousTimersLastUpdate }

        return ([currentDate] + removedPeriodicallyUpdate + continuousTimers.map { $0.endTime }).sorted(by: { $0 < $1 })
    }
}

extension Date {
    func isRange(minute: Int, of target: Date) -> Bool {
        return abs(Int(self.timeIntervalSince(target))) < minute * 60
    }
}
