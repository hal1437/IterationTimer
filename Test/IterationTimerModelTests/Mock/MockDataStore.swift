//
//  MockDataStore.swift
//  IterationTimerModelTests
//
//  Created by hal1437 on 2021/11/28.
//

import Foundation
@testable import IterationTimerModel

class MockDataStore: DataStore {
    var onGet: ((String) -> String?)?
    var onSet: ((String?, String) -> Void)?
    
    func `get`(forKey: String) -> String? {
        return onGet?(forKey)
    }
    
    func `set`(value: String?, forKey: String) {
        onSet?(value, forKey)
    }
}
