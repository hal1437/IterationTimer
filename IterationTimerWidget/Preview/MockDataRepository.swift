//
//  MockDataRepository.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/27.
//

import Foundation
import IterationTimerCore
import IterationTimerModel

class EmptyMockTimerRepository: IterationTimerRepositoryProtocol {
    var getTimers: [IterationTimer] = []
    var recentTimer: IterationTimer?
    
    func insertTimer(index: Int, timer: IterationTimer) {}
    
    func updateTimer(id: UUID, timer: IterationTimer) {}
    
    func deleteTimer(id: UUID) {}
}

class MockTimerRepository: IterationTimerRepositoryProtocol {
    var getTimers: [IterationTimer] = [.init(currentStamina: 100,
                                             settings: try! .init(title: "Sample1",
                                                                  category: .game,
                                                                  maxStamina: 160,
                                                                  divideStamina: 40,
                                                                  duration: 480,
                                                                  notification: .never),
                                             since: Date()),
                                       .init(currentStamina: 200,
                                             settings: try! .init(title: "Sample2",
                                                                  category: .game,
                                                                  maxStamina: 240,
                                                                  divideStamina: 40,
                                                                  duration: 300,
                                                                  notification: .never),
                                             since: Date()),
                                      ]
    var recentTimer: IterationTimer? { getTimers[0] }
    
    func insertTimer(index: Int, timer: IterationTimer) {}
    
    func updateTimer(id: UUID, timer: IterationTimer) {}
    
    func deleteTimer(id: UUID) {}
}
