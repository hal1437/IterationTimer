//
//  TimerDataSet.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/12/04.
//

import Foundation
import IterationTimerModel

// テスト用タイマーセット
let timerDataSet = [
    IterationTimer(currentStamina: 0,
                   settings: try! .init(title: "TestTimer1",
                                        category: .game,
                                        maxStamina: 100,
                                        divideStamina: 10,
                                        duration: TimeInterval(60),
                                        notification: .never),
                   since: Date(timeIntervalSince1970: TimeInterval(0))),
    IterationTimer(currentStamina: 40,
                   settings: try! .init(title: "TestTimer1",
                                        category: .game,
                                        maxStamina: 120,
                                        divideStamina: 30,
                                        duration: TimeInterval(120),
                                        notification: .never),
                   since: Date(timeIntervalSince1970: TimeInterval(60))),
]
