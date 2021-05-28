//
//  TimerListsViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Combine
import Foundation
import IterationTimerModel

class TimerListsViewModel: ObservableObject {
    
    @Published var timers: [IterationTimerUnit]
    @Published var isTransitionAddTimer = false
    @Published var isTransitionEditTimer = false
    @Published var currentTime = Date()
    
    private var repository: IterationTimerRepositoryProtocol
    private var timerCancellable: AnyCancellable?

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
        timers = repository.getTimers
        
        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .filter { _ in !self.isTransitionAddTimer && !self.isTransitionEditTimer }
            .sink { _ in self.currentTime = Date() }
        
    }
    
    func transitonAddView() {
        isTransitionAddTimer = true
    }

    func transitonEditView() {
        isTransitionEditTimer = true
    }
    
    func refreshTimers() {
        timers = repository.getTimers
    }
}
