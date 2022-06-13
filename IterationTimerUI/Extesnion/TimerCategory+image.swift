//
//  TimerCategory+image.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/10.
//

import Foundation
import UIKit

public extension TimerCategory {
    var image: UIImage {
        switch self {
        case .game:
            return UIImage(systemName: "gamecontroller")!.withTintColor(.label)
        }
    }

    var systemName: String {
        switch self {
        case .game:
            return "gamecontroller"
        }
    }
}
