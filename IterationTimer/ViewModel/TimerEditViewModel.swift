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
    
    @Published var timer: IterationTimer
    @Published var category = TimerCategory.game
    @Published var name = "name"
    @Published var currentValue = "10"
    @Published var maxValue = "10"
    @Published var duration = "10"
    private var mode: TimerEditView.Mode

    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode
        
        switch mode {
        case .add:
            self.timer = .init(currentStamina: 10,settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, duration: 10), since: Date())
        case .edit(let timer):
            self.timer = timer
        }

        self.name = timer.settings.title
        self.currentValue = "\(timer.currentStamina(date: Date()))"
        self.maxValue = "\(timer.settings.maxStamina)"
        self.duration = "\(Int(timer.settings.duration))"

        let setting = Publishers.CombineLatest4($name,
                                                Just(TimerCategory.game),
                                                $maxValue.compactMap(Int.init),
                                                $duration.compactMap(TimeInterval.init))
            .map { try? IterationTimerSettings(title: $0, category: $1, maxStamina: $2, duration: $3) }
        
        let timer = Publishers.CombineLatest($currentValue.compactMap { Int($0) },
                                             setting.compactMap { $0 })
            .map { ($0, $1, Date()) }
            .map(IterationTimer.init)
        
        timer.assign(to: \.timer, on: self).store(in: &cancellables)
    }

    func done() {
        switch mode {
        case .add:
            let count = repository.getTimers.count
            repository.insertTimer(index: count, timer: timer)
        case .edit(let unit):
            repository.updateTimer(id: unit.id, timer: timer)
        }
    }

    func delete() {
        if case .edit(let unit) = mode {
            repository.deleteTimer(id: unit.id)
        }
    }

}
