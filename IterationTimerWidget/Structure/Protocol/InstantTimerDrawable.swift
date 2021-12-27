//
//  InstantTimerDrawable.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/06/10.
//

import IterationTimerCore
import IterationTimerModel

public protocol InstantTimerDrawable {
    var category: TimerCategory { get }
    var id: UUID { get }
    var title: String { get }
    var currentStamina: Int { get }
    var maxStamina: Int { get }
    var remainingFull: TimeInterval { get }
}

struct InstantDrawable: InstantTimerDrawable {
    private var timer: IterationTimer
    private var date: Date
    init(timer: IterationTimer, date: Date) {
        self.timer = timer
        self.date = date
    }
    
    var id: UUID { timer.id }
    var category: TimerCategory { timer.settings.category }
    var title: String { timer.settings.title }
    var currentStamina: Int { timer.currentStamina(date: date) }
    var maxStamina: Int { timer.settings.maxStamina }
    var remainingOne: TimeInterval { timer.remainingOne(date: date) }
    var remainingFull: TimeInterval { timer.remainingFull(date: date) }
}

