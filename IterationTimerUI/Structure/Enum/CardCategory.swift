//
//  CardCategory.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/10.
//

import Foundation
import UIKit

public enum CardCategory {
    case game
    
    var image: UIImage {
        switch self {
        case .game:
            return UIImage(systemName: "gamecontroller")!
        }
    }
}
