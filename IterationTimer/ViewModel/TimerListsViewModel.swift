//
//  TimerListsViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Combine
import Foundation

class TimerListsViewModel: ObservableObject {
    
    @Published var timers: [IterationTimerUnit]
    @Published var isTransitionAddTimer = false
    @Published var currentTime = Date()
    
    private var timerCancellable: AnyCancellable?

    init() {
        timers = [IterationTimerUnit(uuid: UUID(), title: "Sample Title", category: .game,
                                     startTime: Date(),
                                     endTime: Date().advanced(by: TimeInterval(60)),
                                     duration: TimeInterval(10)),
                  IterationTimerUnit(uuid: UUID(), title: "Sample Title2", category: .game,
                                     startTime: Date(),
                                     endTime: Date().advanced(by: TimeInterval(180)),
                                     duration: TimeInterval(6))]
        
        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .filter { _ in !self.isTransitionAddTimer }
            .sink { _ in self.currentTime = Date() }
        
    }
    
    func transitonAddView() {
        isTransitionAddTimer = true
    }
}
