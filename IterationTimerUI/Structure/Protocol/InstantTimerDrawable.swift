//
//  InstantTimerDrawable.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/06/10.
//

public protocol InstantTimerDrawable {
    var category: TimerCategory { get }
    var title: String { get }
    var currentStamina: Int { get }
    var maxStamina: Int { get }
}
