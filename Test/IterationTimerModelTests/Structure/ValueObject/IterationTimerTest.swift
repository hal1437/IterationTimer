//
//  IterationTimerTest.swift
//  IterationTimerCoreTests
//
//  Created by hal1437 on 2021/05/29.
//

import XCTest
@testable import IterationTimerModel

class IterationTimerTest: XCTestCase {

    func testInitialize() throws {
        let properties = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: 222)
        XCTAssertEqual(properties.title, "xxx")
        XCTAssertEqual(properties.category, .game)
        XCTAssertEqual(properties.maxStamina, 111)
        XCTAssertEqual(properties.duration, 222)
    }

    func testUnexpedtedInitialize() throws {
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: -1, duration: 222))
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: -1))
    }

    func testUnexpedtedInitializeZero() throws {
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 0, duration: 222))
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: 0))
    }
}
