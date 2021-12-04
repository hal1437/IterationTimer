//
//  UserDefaults+AppGroups.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2021/06/13.
//

import Foundation

public extension UserDefaults {
    static var appGroups: UserDefaults = UserDefaults(suiteName: "group.IterationTimer.timers")!
}
