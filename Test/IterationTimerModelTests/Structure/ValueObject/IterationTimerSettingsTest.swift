//
//  IterationTimerSettingsTest.swift
//  IterationTimerCoreTests
//
//  Created by hal1437 on 2021/05/29.
//

import XCTest
@testable import IterationTimerModel

class IterationTimerSettingsTest: XCTestCase {

    let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 10)
    let baseDate = Date(timeIntervalSince1970: 0)

    func testProperties1() throws {
        let settings1 = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 80, duration: 1)
        let timer1 = IterationTimer(currentStamina: 10, settings: settings1, since: baseDate)
        let now = Date(timeIntervalSince1970: 60) // 1分後

        XCTAssertEqual(timer1.currentStamina(date: now), 70)
        XCTAssertEqual(timer1.remainingOne(date: now), 1) // 0秒にはならない
        XCTAssertEqual(timer1.remainingFull(date: now), 10)
    }

    func testProperties2() throws {
        let settings1 = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 70)
        let timer1 = IterationTimer(currentStamina: 0, settings: settings1, since: baseDate)
        let now = Date(timeIntervalSince1970: 60) // 1分後

        XCTAssertEqual(timer1.remainingOne(date: now), 10)
    }

    func testUnexpedtedInitialize() throws {
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: -1, duration: 222))
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: -1))
    }
}
