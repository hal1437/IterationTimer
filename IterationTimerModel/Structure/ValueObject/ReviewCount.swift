//
//  ReviewCount.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2021/12/14.
//

struct ReviewCount {
    static let reviewCountCoolTime = 3
    var count: Int
    let dataStore: DataStore

    var requireReview: Bool { count == 0 }
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore

        guard let countString = dataStore.get(forKey: DataStoreKey.reviewCount.rawValue),
              let count = Int(countString) else {
            self.count = ReviewCount.reviewCountCoolTime
            return
        }
        
        self.count = max(min(count, ReviewCount.reviewCountCoolTime), 0)
    }

    mutating func decrement() {
        if requireReview {
            count = ReviewCount.reviewCountCoolTime
        } else {
            count = count - 1
        }
        dataStore.set(value: String(count), forKey: DataStoreKey.reviewCount.rawValue)
    }
}
