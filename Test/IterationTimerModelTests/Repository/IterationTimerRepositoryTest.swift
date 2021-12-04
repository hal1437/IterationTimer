//
//  IterationTimerRepositoryTest.swift
//  IterationTimerModelTests
//
//  Created by hal1437 on 2021/12/04.
//

import XCTest
@testable import IterationTimerModel

class IterationTimerRepositoryTest: XCTestCase {
    let userdefaults = UserDefaults(suiteName: "IterationTimerRepositoryTest")!
    lazy var repo = IterationTimerRepository(dataStore: userdefaults)

    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: "IterationTimerRepositoryTest")
    }
    
    func testInitialize() throws {
        guard let dataStore = repo.dataStore as? UserDefaults else {
            XCTFail()
            return
        }
        XCTAssertEqual(dataStore, userdefaults)
        
    }
    
    func testInsertTimer() throws {
        XCTAssertEqual(repo.getTimers, [])

        repo.insertTimer(index: 0, timer: timerDataSet[0])
        XCTAssertEqual(repo.getTimers, [timerDataSet[0]])

        repo.insertTimer(index: 0, timer: timerDataSet[1])
        XCTAssertEqual(repo.getTimers, [timerDataSet[1], timerDataSet[0]])

        repo.insertTimer(index: 2, timer: timerDataSet[1])
        XCTAssertEqual(repo.getTimers, [timerDataSet[1], timerDataSet[0], timerDataSet[1]])
    }
    
    func testUpdateTimer() throws {
        repo.insertTimer(index: 0, timer: timerDataSet[0])
        let afterTimer = timerDataSet[0].then { $0.settings.title = "XXX" }
        XCTAssertEqual(repo.getTimers, [timerDataSet[0]])
        
        repo.updateTimer(id: timerDataSet[0].id, timer: afterTimer)
        XCTAssertEqual(repo.getTimers, [afterTimer])

        repo.updateTimer(id: timerDataSet[1].id, timer: timerDataSet[0])
        XCTAssertEqual(repo.getTimers, [afterTimer])
    }
    
    func testDeleteTimer() throws {
        repo.insertTimer(index: 0, timer: timerDataSet[0])
        repo.deleteTimer(id: timerDataSet[0].id)
        XCTAssertEqual(repo.getTimers, [])
    }

    override func tearDown() {
        UserDefaults().removePersistentDomain(forName: "IterationTimerRepositoryTest")
        super.tearDown()
    }
}


extension IterationTimer: Equatable {
    public static func == (lhs: IterationTimer, rhs: IterationTimer) -> Bool {
        return lhs.id == rhs.id
    }
}

extension IterationTimer {
    func then(closure: (inout IterationTimer) -> Void) -> IterationTimer {
        var t = self
        closure(&t)
        return t
    }
}
