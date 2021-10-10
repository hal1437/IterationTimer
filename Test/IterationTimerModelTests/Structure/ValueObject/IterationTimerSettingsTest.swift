//
//  IterationTimerSettingsTest.swift
//  IterationTimerCoreTests
//
//  Created by hal1437 on 2021/05/29.
//

import XCTest
@testable import IterationTimerModel

class IterationTimerSettingsTest: XCTestCase {

    let baseDate = Date(timeIntervalSince1970: 0)

    func testDuration1() throws {
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 80, duration: 1, notification: .never)
        let timer = IterationTimer(currentStamina: 10, settings: settings, since: baseDate)
        let now = Date(timeIntervalSince1970: 60) // 1分後

        XCTAssertEqual(timer.currentStamina(date: now), 70, "現在のスタミナがdurationが1の場合、1分後には60増えていること")
        XCTAssertEqual(timer.remainingOne(date: now), 1, "次のスタミナ回復時間が1秒後であること") // 0秒にはならない
        XCTAssertEqual(timer.remainingFull(date: now), 10, "全てのスタミナ回復時間が10秒後であること")
    }

    func testDuration70() throws {
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 70, notification: .never)
        let timer = IterationTimer(currentStamina: 0, settings: settings, since: baseDate)
        let now = Date(timeIntervalSince1970: 60) // 1分後

        XCTAssertEqual(timer.remainingOne(date: now), 10, "現在のスタミナがdurationが70の場合、1分後でも増えていないこと")
    }

    func testOverCurrentStamina() throws {
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 10, notification: .never)
        let timer = IterationTimer(currentStamina: 0, settings: settings, since: baseDate)
        let now = Date(timeIntervalSince1970: 120) // 2分後

        XCTAssertEqual(timer.currentStamina(date: now), 10, "現在のスタミナがスタミナの最大値を超えないこと")
    }
    
    func testInitialize() throws {
        XCTAssertNoThrow(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: 222, notification: .never), "正常な値で初期化できること")
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: -1, duration: 222, notification: .never), "スタミナがマイナスでは初期化出来ないこと")
        XCTAssertThrowsError(try IterationTimerSettings(title: "xxx", category: .game, maxStamina: 111, duration: -1, notification: .never), "durationがマイナスでは初期化出来ないこと")
    }
    
    func testNotifyNever() throws {
        let anotherDate = Date(timeIntervalSince1970: 111)
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 10, notification: .never)
        let timer = IterationTimer(currentStamina: 0, settings: settings, since: anotherDate)

        XCTAssertEqual(timer.nextNotifyDate(), Date(timeIntervalSince1970: 0))
    }

    func testNotifyOn() throws {
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 10, notification: .on(stamina: 9))
        let timer = IterationTimer(currentStamina: 0, settings: settings, since: baseDate)

        XCTAssertEqual(timer.nextNotifyDate(), Date(timeIntervalSince1970: 90))
    }

    func testNotifyComplete() throws {
        let settings = try! IterationTimerSettings(title: "xxx", category: .game, maxStamina: 10, duration: 10, notification: .completion(before: TimeInterval(9)))
        let timer = IterationTimer(currentStamina: 0, settings: settings, since: baseDate)

        XCTAssertEqual(timer.nextNotifyDate(), Date(timeIntervalSince1970: 91))
    }
}
