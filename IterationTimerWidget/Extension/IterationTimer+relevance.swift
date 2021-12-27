//
//  IterationTimer+relevance.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/28.
//

import IterationTimerModel
import WidgetKit

extension IterationTimer {
    func relevance(date: Date) -> TimelineEntryRelevance {
        return TimelineEntryRelevance(score: Float(self.currentStamina(date: date)))
    }
}
