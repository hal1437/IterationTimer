//
//  MultipleTimerViewModel.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/06/11.
//

import Combine
import IterationTimerModel


class MultipleTimerViewModel: ObservableObject {
    @Published var timers: [IterationTimer]
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
        timers = repository.getTimers
    }
}
