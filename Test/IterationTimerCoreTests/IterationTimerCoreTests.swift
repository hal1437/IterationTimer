//
//  IterationTimerCoreTests.swift
//  IterationTimerCoreTests
//
//  Created by hal1437 on 2021/04/07.
//

@testable import IterationTimerModel
import XCTest

class IterationTimerCoreTests: XCTestCase {

    func testSum() throws {
        XCTAssertEqual(sum(a: 1, b: 1), 2)
    }
}
