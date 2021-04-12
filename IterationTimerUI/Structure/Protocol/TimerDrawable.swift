//
//  TimerDrawable.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/10.
//

import Foundation

public protocol TimerDrawable {
    var category: CardCategory { get }
    var title: String { get }
    var startTime: Date { get }
    var currentTime: Date { get }
    var endTime: Date { get }
    var duration: TimeInterval { get }
}
