//
//  StoreReviewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/12/14.
//

public class StoreReviewModel {
    let reviewer: Reviewable
    var reviewCount: ReviewCount
    
    init(reviewer: Reviewable, dataStore: DataStore) {
        self.reviewer = reviewer
        self.reviewCount = ReviewCount(dataStore: dataStore)
    }
    
    func requestReview() {
        if reviewCount.requireReview {
            reviewer.requestReview()
        }
        reviewCount.decrement()
    }
}
