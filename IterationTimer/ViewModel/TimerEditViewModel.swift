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
    @Published var currentValue = "10"
    @Published var maxValue = "10"
    @Published var duration = "10"
    private var mode: TimerEditView.Mode

    private var cancellable: AnyCancellable?
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode
                
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
        
        if case .edit(let unit) = mode {
            self.setDetaultValue(timer: unit)
        }

    }

    func setDetaultValue(timer: IterationTimerUnit) {
        name = timer.title
        currentValue = "\(timer.currentUnitCount(date: Date()))"
        maxValue = "\(timer.maxUnitCount)"
        duration = "\(timer.duration)"
    }

    func done() {
        switch mode {
        case .add:
            let count = repository.getTimers.count
            repository.insertTimer(index: count, timer: timer)
        case .edit(let unit):
            repository.updateTimer(uuid: unit.uuid, timer: timer)
        }
    }

    func delete() {
        if case .edit(let unit) = mode {
            repository.deleteTimer(uuid: unit.uuid)
        }
    }

}
