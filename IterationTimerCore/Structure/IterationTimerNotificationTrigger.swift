//
//  IterationTimerNotificationTrigger.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2022/09/12.
//

import Foundation

public enum IterationTimerNotificationTrigger: Codable, Equatable {
    case never // 通知を行わない
    case on(stamina: Int) // 現在のスタミナがXXとなった時
    case completion(before: TimeInterval) // 完了時からの相対時刻
}
