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
        XCTAssertEqual(reviewCount.count, 3)
    }

    func testDecrement() throws {
        var reviewCount = ReviewCount(dataStore: userDefaults)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.count, 2)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.count, 1)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.count, 0)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.count, 3)
    }

    func testRequireReview() throws {
        var reviewCount = ReviewCount(dataStore: userDefaults)
        XCTAssertEqual(reviewCount.requireReview, false)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.requireReview, false)
        reviewCount.decrement()
        XCTAssertEqual(reviewCount.requireReview, false)
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

