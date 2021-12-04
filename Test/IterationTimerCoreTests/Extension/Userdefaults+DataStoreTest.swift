//
//  Userdefaults+DataStoreTest.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/12/04.
//

@testable import IterationTimerCore
import XCTest

class UserdefaultsDataStoreTest: XCTestCase {
    let userdefaults = UserDefaults(suiteName: String(describing: type(of: self)))!
    
    func testSet() throws {
        let dataStore: DataStore = userdefaults
        dataStore.set(value: "test", forKey: "test")
        
        XCTAssertEqual(userdefaults.string(forKey: "test"), "test")
    }

    func testGet() throws {
        userdefaults.set(value: "test", forKey: "test")

        let dataStore: DataStore = userdefaults
        XCTAssertEqual(dataStore.get(forKey: "test"), "test")
    }
    
    override func tearDown() {
        userdefaults.removePersistentDomain(forName: String(describing: type(of: self)))
        super.tearDown()
    }
}
