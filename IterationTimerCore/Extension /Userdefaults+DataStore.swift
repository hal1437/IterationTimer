//
//  Userdefaults+DataStore.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2021/10/27.
//

import Foundation

extension UserDefaults: DataStore {
    public func `get`(forKey: String) -> String? {
        return string(forKey: forKey)
    }
    
    public func `set`(value: String?, forKey: String) {
         set(value, forKey: forKey)
    }
}
