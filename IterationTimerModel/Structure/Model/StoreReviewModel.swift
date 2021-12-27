//
//  StoreReviewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/12/14.
//

public protocol StoreReviewable {
    func requestReviewIfNeeded()
}

public class StoreReviewModel: StoreReviewable {
    let reviewer: Reviewable
    var reviewCount: ReviewCount
    
    public init(reviewer: Reviewable, dataStore: DataStore) {
        self.reviewer = reviewer
        self.reviewCount = ReviewCount(dataStore: dataStore)
    }
    
    public func requestReviewIfNeeded() {
        if reviewCount.requireReview {
            reviewer.requestReview()
        }
        reviewCount.decrement()
    }
}
