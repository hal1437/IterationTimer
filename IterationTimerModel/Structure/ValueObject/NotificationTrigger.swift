//
//  NotificationTrigger.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2021/10/09.
//

import Foundation

public enum NotificationTrigger: Codable, Equatable {
    case never // 通知を行わない
    case on(stamina: Int) // 現在のスタミナがXXとなった時
    case completion(offset: TimeInterval) // 完了時からの相対時刻
}
