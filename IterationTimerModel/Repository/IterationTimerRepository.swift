//
//  IterationTimerRepository.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2021/04/27.
//

import Foundation

public protocol IterationTimerRepositoryProtocol {
    var getTimers: [IterationTimerUnit] { get }
    func insertTimer(index: Int, timer: IterationTimerUnit)
}


public struct IterationTimerRepository: IterationTimerRepositoryProtocol {
    let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    public var getTimers: [IterationTimerUnit] {
        guard let json = userDefaults.string(forKey: UserDefaultsKey.iterationTimer.rawValue),
              let data = json.data(using: .utf8),
              let array = try? JSONDecoder().decode([IterationTimerUnit].self, from: data) else { return [] }
        
        return array
    }
    
    public func insertTimer(index: Int, timer: IterationTimerUnit) {
        var array = getTimers
        array.insert(timer, at: index)
        
        let json = try! JSONEncoder().encode(array)
        let string = String(data: json, encoding: .utf8)!
        
        userDefaults.setValue(string, forKeyPath: UserDefaultsKey.iterationTimer.rawValue)
    }
    
}
