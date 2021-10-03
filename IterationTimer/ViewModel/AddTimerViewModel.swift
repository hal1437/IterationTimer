//
//  AddTimerViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import Combine
import Foundation
import IterationTimerModel

class AddTimerViewModel: ObservableObject {
    
    @Published var timer: IterationTimer
    @Published var category = TimerCategory.game
    @Published var name = "name"
    @Published var maxValue = "10"
    @Published var duration = "10"
    @Published var isCompleteNotification = false
    @Published var willPushNotify = false

    private var cancellable: AnyCancellable?
    private var repository: IterationTimerRepositoryProtocol

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
        timer = IterationTimer(currentStamina: 0,
                               settings: try! .init(title: "NO NAME",
                                                    category: .game,
                                                    maxStamina: 10,
                                                    duration: 60,
                                                    willPushNotify: false),
                               since: Date())
        
        cancellable = $name
            .combineLatest($maxValue.compactMap { Int($0) },
                           $duration.compactMap { TimeInterval($0) },
                           $willPushNotify)
            .sink { name, maxValue, duration, willPushNotify in
                self.timer = IterationTimer(currentStamina: 0,
                                            settings: try! .init(title: name,
                                                                 category: .game,
                                                                 maxStamina: maxValue,
                                                                 duration: duration,
                                                                 willPushNotify: willPushNotify),
                                            since: Date())
            }
    }
    
    func addTimer() {
        let count = repository.getTimers.count
        repository.insertTimer(index: count, timer: timer)
    }

}
