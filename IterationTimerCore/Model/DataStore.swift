//
//  DataStore.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2021/10/27.
//

import Foundation

public protocol DataStore {
    func `get`(forKey: String) -> String?
    func `set`(value: String?, forKey: String)
}
