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

    private var cancellable: AnyCancellable?
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode
                
        timer = IterationTimer(currentStamina: 10, settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, duration: 10), since: Date())
        
        cancellable = $name
            .combineLatest($maxValue.compactMap { Int($0) }, $duration.compactMap { TimeInterval($0) })
            .sink { name, maxValue, duration in
                
                self.timer = IterationTimer(currentStamina: 10,
                                            settings: try! .init(title: name,
                                                                 category: .game,
                                                                 maxStamina: maxValue,
                                                                 duration: duration),
                                            since: Date())
            }
        
        if case .edit(let unit) = mode {
            self.setDetaultValue(timer: unit)
        }

    }

    func setDetaultValue(timer: IterationTimer) {
        name = timer.settings.title
        currentValue = "\(timer.currentStamina(date: Date()))"
        maxValue = "\(timer.settings.maxStamina)"
        duration = "\(timer.settings)"
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
