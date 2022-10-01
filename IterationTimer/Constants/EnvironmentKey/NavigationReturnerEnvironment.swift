//
//  NavigationReturnerEnvironment.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/19.
//

import SwiftUI

// モーダルで表示されたNavigationViewがモーダルごと閉じるための環境変数
struct NavigationReturnerEnvironmentKey: EnvironmentKey {
  typealias Value = DismissAction?
  
  static var defaultValue: Value = nil
}

extension EnvironmentValues {
  var navigationReturner: DismissAction? {
    get {
      return self[NavigationReturnerEnvironmentKey.self]
    }
    set {
      self[NavigationReturnerEnvironmentKey.self] = newValue
    }
  }
}
