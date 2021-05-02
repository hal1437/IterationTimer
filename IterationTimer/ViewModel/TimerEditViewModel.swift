//
//  TimerEditViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import Combine
import Foundation
import IterationTimerModel

class TimerEditViewModel: ObservableObject {
    
    @Published var timer: IterationTimerUnit
    @Published var category = TimerCategory.game
    @Published var name = "name"
    @Published var maxValue = "10"
    @Published var duration = "10"
    @Published var isCompleteNotification = false

    private var cancellable: AnyCancellable?
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
        timer = IterationTimerUnit(uuid: UUID(),
                                   title: "NO NAME",
                                   category: .game,
                                   startTime: Date(timeIntervalSinceNow: 0),
                                   endTime: Date(timeIntervalSinceNow: 600),
                                   duration: TimeInterval(60))
        
        cancellable = $name
            .combineLatest($maxValue.compactMap { Int($0) }, $duration.compactMap { Int($0) })
            .sink { name, maxValue, duration in
                self.timer = IterationTimerUnit(uuid: UUID(),
                                                title: name,
                                                category: .game,
                                                startTime: Date(timeIntervalSinceNow: 0),
                                                endTime: Date(timeIntervalSinceNow: TimeInterval(maxValue * duration)),
                                                duration: TimeInterval(duration))
            }
    }
    
    func addTimer() {
        let count = repository.getTimers.count
        repository.insertTimer(index: count, timer: timer)
    }

}
