//
//  WidgetUpdateTimeCreatorTest.swift
//  IterationTimerModel
//
//  Created by hal1437 on 2022/10/09.
//

import XCTest
@testable import IterationTimerModel

class WidgetUpdateTimeCreatorTest: XCTestCase {
    
    private let currentDate = Date(timeIntervalSince1970: 0)
    
    private func timerCreate(reafreshAfter minute: Int) -> IterationTimer {
        return IterationTimer(currentStamina: 0, settings: try! .init(title: "", category: .game, maxStamina: 1, divideStamina: 1, duration: TimeInterval(60 * minute), notification: .never), since: currentDate)
    }
    
    func testNever() {
        let mock = IterationTimerRepositoryMock(timers: [])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate], "タイマーがない場合は更新しない")
    }

    func testOnece() {
        let mock = IterationTimerRepositoryMock(timers: [timerCreate(reafreshAfter: 1)])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate,
                                                                  currentDate.plusM(1)], "定期更新よりもタイマーの最終値が早ければそれのみ更新する")
    }
    
    func testTwice() {
        let mock = IterationTimerRepositoryMock(timers: [timerCreate(reafreshAfter: 30)])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate,
                                                                  currentDate.plusM(15),
                                                                  currentDate.plusM(30)], "タイマーの最終値以前の定期更新は削除する")
    }
    
    func testOverwrite() {
        let mock = IterationTimerRepositoryMock(timers: [timerCreate(reafreshAfter: 44)])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate,
                                                                  currentDate.plusM(15),
                                                                  //currentDate.plusM(30),
                                                                  currentDate.plusM(44)], "タイマーの更新時間から前後15分未満の定期更新は削除する")
    }

    func testPeriodically() {
        let mock = IterationTimerRepositoryMock(timers: [timerCreate(reafreshAfter: 150)])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate,
                                                                  currentDate.plusM(15),
                                                                  currentDate.plusM(30),
                                                                  currentDate.plusM(45),
                                                                  currentDate.plusM(60),
                                                                  currentDate.plusM(75),
                                                                  currentDate.plusM(90),
                                                                  currentDate.plusM(105),
                                                                  currentDate.plusM(120),
                                                                  currentDate.plusM(150)])
    }

    func testMultipleTimerOverwrite() {
        let mock = IterationTimerRepositoryMock(timers: [timerCreate(reafreshAfter: 20),timerCreate(reafreshAfter: 40)])
        let creator = WidgetUpdateTimeCreator(repository: mock)
        
        XCTAssertEqual(creator.create(currentDate: currentDate), [currentDate,
                                                                  currentDate.plusM(20),
                                                                  currentDate.plusM(40)])
    }
}

extension Date {
    func plusM(_ minute: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(60 * minute))
    }
}
