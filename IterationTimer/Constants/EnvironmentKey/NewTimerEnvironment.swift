//
//  NewTimerEnvironment.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/10/01.
//

import SwiftUI

// モーダルで表示されたNavigationViewがモーダルごと閉じるための環境変数
struct NewTimerEnvironmentKey: EnvironmentKey {
    typealias Value = NewTimerProperties?
    static var defaultValue: Value = nil
}

extension EnvironmentValues {
    var newTimerProperties: NewTimerProperties? {
        get {
            return self[NewTimerEnvironmentKey.self]
        }
        set {
            self[NewTimerEnvironmentKey.self] = newValue
        }
    }
}
