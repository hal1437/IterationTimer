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
    @Published var currentTime = Timer.publish(every: 1, on: .main, in: .common).autoconnect().map { _ in Date() }

    init() {
        timers = [IterationTimerUnit(uuid: UUID(), title: "Sample Title", category: .game,
                                     startTime: Date(),
                                     endTime: Date().advanced(by: TimeInterval(60)),
                                     duration: TimeInterval(10)),
                  IterationTimerUnit(uuid: UUID(), title: "Sample Title2", category: .game,
                                     startTime: Date(),
                                     endTime: Date().advanced(by: TimeInterval(180)),
                                     duration: TimeInterval(6))]
    }
    
}
