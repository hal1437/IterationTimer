//
//  TimerCategory+CardCategory.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Foundation
import IterationTimerUI
import IterationTimerModel

extension TimerCategory {
    var cardCategory: CardCategory {
        switch self {
        case .game: return .game
        }
    }
}
