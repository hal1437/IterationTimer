//
//  TimerCreateConfirmViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/10/01.
//

import Foundation
import IterationTimerCore
import IterationTimerModel

class TimerCreateConfirmViewModel: ObservableObject {
    @Published var done = false
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
    }
    
    func addTimer(timer: IterationTimer) {
        let index = repository.getTimers.count
        repository.insertTimer(index: index, timer: timer)
        done = true
    }
}
