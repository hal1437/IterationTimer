//
//  IterationTimer+TimerCardDrawable.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/06/04.
//

import IterationTimerModel
import IterationTimerUI

struct IterationTimerDrawable: TimerDrawable {
    private var timer: IterationTimer
    private var date: Date
    init(timer: IterationTimer, date: Date) {
        self.timer = timer
        self.date = date
    }
    
    var category: TimerCategory { timer.settings.category }
    var title: String { timer.settings.title }
    var currentStamina: Int { timer.currentStamina(date: date) }
    var maxStamina: Int { timer.settings.maxStamina }
    var divideStamina: Int { timer.settings.divideStamina }
    var remainingOne: TimeInterval { timer.remainingOne(date: date) }
    var remainingFull: TimeInterval { timer.remainingFull(date: date) }
}
