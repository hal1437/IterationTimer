//
//  IterationTimerModelTests.swift
//  IterationTimerModelTests
//
//  Created by hal1437 on 2021/04/07.
//

@testable import IterationTimerModel
import XCTest

class IterationTimerModelTests: XCTestCase {

    func testSum() throws {
        XCTAssertEqual(sum(a: 1, b: 1), 2)
    }
}
