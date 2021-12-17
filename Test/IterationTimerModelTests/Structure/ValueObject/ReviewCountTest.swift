//
//  ReviewCountTest.swift
//  IterationTimerModelTests
//
//  Created by hal1437 on 2021/12/17.
//

import XCTest
@testable import IterationTimerModel

class ReviewCountTest: XCTestCase {

    let userDefaults = UserDefaults(suiteName: "ReviewCountTest")!

    func testInitialize() throws {
        let reviewCount = ReviewCount(dataStore: userDefaults)
        XCTAssertEqual(reviewCount.count, ReviewCount.reviewCountCoolTime)
        XCTAssertEqual(reviewCount.requireReview, false)
    }

    func testDecrement() throws {
        var reviewCount = ReviewCount(dataStore: userDefaults)
        
        (0..<ReviewCount.reviewCountCoolTime).forEach { i in
            reviewCount.decrement()
            XCTAssertEqual(reviewCount.count, ReviewCount.reviewCountCoolTime - i - 1)
        }
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.count, ReviewCount.reviewCountCoolTime, "0の際にdecrementした場合はreviewCountCoolTimeとする")
    }

    func testRequireReview() throws {
        var reviewCount = ReviewCount(dataStore: userDefaults)
        
        (0..<ReviewCount.reviewCountCoolTime - 1).forEach { _ in
            reviewCount.decrement()
            XCTAssertEqual(reviewCount.requireReview, false)
        }
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.requireReview, true)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.requireReview, false)
    }

    func testInitContinuous() throws {
        userDefaults.set("1", forKey: DataStoreKey.reviewCount.rawValue)
        let reviewCount = ReviewCount(dataStore: userDefaults)
        XCTAssertEqual(reviewCount.count, 1)
    }

    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "ReviewCountTest")
        super.tearDown()
    }
}

