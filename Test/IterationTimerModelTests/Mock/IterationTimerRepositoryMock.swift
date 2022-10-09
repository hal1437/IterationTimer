//
//  IterationTimerRepositoryMock.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2022/10/09.
//

import Foundation

struct IterationTimerRepositoryMock: IterationTimerRepositoryProtocol {
    let timers: [IterationTimer]
    var getTimers: [IterationTimer] { timers }
    var recentTimer: IterationTimer? { timers.first }

    func insertTimer(index: Int, timer: IterationTimer) {
    }

    func updateTimer(id: UUID, timer: IterationTimer) {
    }

    func deleteTimer(id: UUID) {
    }
}
