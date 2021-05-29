//
//  TimerDrawable.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/10.
//

import Foundation

public protocol TimerDrawable {
    var category: TimerCategory { get }
    var title: String { get }
    var currentStamina: Int { get }
    var maxStamina: Int { get }
    var remainingOne: TimeInterval { get }
    var remainingFull: TimeInterval { get }
}
