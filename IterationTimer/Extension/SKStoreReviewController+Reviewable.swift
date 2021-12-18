//
//  SKStoreReviewController+Reviewable.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/12/14.
//

import StoreKit
import IterationTimerModel

struct SKStoreReview: Reviewable {
    public func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
