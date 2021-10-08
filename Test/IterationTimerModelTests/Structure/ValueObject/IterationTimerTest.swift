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
        let properties = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: 222, willPushNotify: false)
        XCTAssertEqual(properties.title, "xxx", "適切な値が代入されていること")
        XCTAssertEqual(properties.category, .game, "適切な値が代入されていること")
        XCTAssertEqual(properties.maxStamina, 111, "適切な値が代入されていること")
        XCTAssertEqual(properties.duration, 222, "適切な値が代入されていること")
    }

    func testUnexpedtedInitialize() throws {
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: -1, duration: 222, willPushNotify: false), "スタミナがマイナスでは初期化出来ないこと")
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: -1, willPushNotify: false), "durationがマイナスでは初期化出来ないこと")
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 0, duration: 222, willPushNotify: false), "スタミナが0では初期化出来ないこと")
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: 0, willPushNotify: false), "durationが0では初期化出来ないこと")
    }
}
