//
//  Defaults.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/07/09.
//

import Foundation
import IterationTimerModel

extension IterationTimer {
    static var `default` = IterationTimer(currentStamina: 10, settings: .default, since: Date())
}

extension IterationTimerSettings {
    static var `default` = try! IterationTimerSettings(title: "",
                                                       category: .game,
                                                       maxStamina: 10,
                                                       divideStamina: 0,
                                                       duration: 10,
                                                       notification: .never)
}
