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
    
    struct Inputs {
        var timer = IterationTimer(currentStamina: 10,
                                   settings: try! .init(title: "NO NAME",
                                                        category: .game,
                                                        maxStamina: 10,
                                                        duration: 10,
                                                        willPushNotify: false),
                                   since: Date())
        var category = TimerCategory.game
        var name = ""
        var currentValue = "10"
        var maxValue = "10"
        var duration = "10"
        var willPushNotify = false
    }
    
    @Published var input: Inputs = Inputs()
    private var mode: TimerEditView.Mode

    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode

        if case .edit(let timer) = mode {
            self.input.timer = timer
        }
    }

    func done() {
        let timer = input.timer
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
