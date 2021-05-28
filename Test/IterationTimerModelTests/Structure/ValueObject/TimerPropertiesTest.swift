//
//  TimerPropertiesTest.swift
//  IterationTimerCoreTests
//
//  Created by hal1437 on 2021/05/29.
//

import XCTest
@testable import IterationTimerModel

class TimerPropertiesTest: XCTestCase {

    func testInitialize() throws {
        let properties = try! TimerProperties(title: "xxx", category: .game, maxStamina: 111, duration: 222)
        XCTAssertEqual(properties.title, "xxx")
        XCTAssertEqual(properties.category, .game)
        XCTAssertEqual(properties.maxStamina, 111)
        XCTAssertEqual(properties.duration, 222)
    }

    func testUnexpedtedInitialize() throws {
        XCTAssertThrowsError(try TimerProperties(title: "xxx", category: .game, maxStamina: -1, duration: 222))
        XCTAssertThrowsError(try TimerProperties(title: "xxx", category: .game, maxStamina: 111, duration: -1))
    }
}
