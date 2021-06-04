//
//  IterationTimerRepository.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2021/04/27.
//

import Foundation

public protocol IterationTimerRepositoryProtocol {
    var getTimers: [IterationTimer] { get }
    func insertTimer(index: Int, timer: IterationTimer)
    func updateTimer(id: UUID, timer: IterationTimer)
    func deleteTimer(id: UUID)
}

public struct IterationTimerRepository: IterationTimerRepositoryProtocol {
    let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    public var getTimers: [IterationTimer] {
        guard let json = userDefaults.string(forKey: UserDefaultsKey.iterationTimer.rawValue),
              let data = json.data(using: .utf8),
              let array = try? JSONDecoder().decode([IterationTimer].self, from: data) else { return [] }
        
        return array
    }
    
    public func insertTimer(index: Int, timer: IterationTimer) {
        var array = getTimers
        array.insert(timer, at: index)
        update(array)
    }

    public func updateTimer(id: UUID, timer: IterationTimer) {
        update(getTimers.map { $0.id == id ? timer : $0 })
    }

    public func deleteTimer(id: UUID) {
        update(getTimers.filter { $0.id != id })
    }
    
    private func update(_ array: [IterationTimer]) {
        let json = try! JSONEncoder().encode(array)
        let string = String(data: json, encoding: .utf8)!
        
        userDefaults.setValue(string, forKeyPath: UserDefaultsKey.iterationTimer.rawValue)
    }
}
