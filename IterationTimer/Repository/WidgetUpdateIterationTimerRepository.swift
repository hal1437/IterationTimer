//
//  WidgetUpdateIterationTimerRepository.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/10/09.
//

import Foundation
import IterationTimerModel
import WidgetKit

struct WidgetUpdateIterationTimerRepository: IterationTimerRepositoryProtocol {
    let repository: IterationTimerRepository
    
    init(dataStore: DataStore) {
        repository = IterationTimerRepository(dataStore: dataStore)
    }
    
    var getTimers: [IterationTimer] { repository.getTimers }
    var recentTimer: IterationTimer? { repository.recentTimer }

    func insertTimer(index: Int, timer: IterationTimer) {
        repository.insertTimer(index: index, timer: timer)
        WidgetCenter.shared.reloadAllTimelines()
    }

    func updateTimer(id: UUID, timer: IterationTimer) {
        repository.updateTimer(id: id, timer: timer)
        WidgetCenter.shared.reloadAllTimelines()
    }

    func deleteTimer(id: UUID) {
        repository.deleteTimer(id: id)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
