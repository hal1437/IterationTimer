//
//  DataStoreSynchronizerTest.swift
//  IterationTimerModelTests
//
//  Created by hal1437 on 2021/11/28.
//

import XCTest
@testable import IterationTimerModel

class DataStoreSynchronizerTest: XCTestCase {

    func testMigration() throws {
        let local = SynchronizerMockDataStore(initial: [.updateDate: nil, .iterationTimer: "local"])
        let remote = SynchronizerMockDataStore(initial: [.updateDate: nil, .iterationTimer: "remote"])
        
        let sync = DataStoreSynchronizer(local: local, remote: remote)
        
        XCTAssertEqual(sync.get(forKey: DataStoreKey.iterationTimer.rawValue), "remote",
                       "2つのタイマーのIntervalが0の場合はremoteを優先する。")
    }

    func testGetLocal() throws {
        let local = SynchronizerMockDataStore(initial: [.updateDate: "2", .iterationTimer: "local"])
        let remote = SynchronizerMockDataStore(initial: [.updateDate: "1", .iterationTimer: "remote"])
        
        let sync = DataStoreSynchronizer(local: local, remote: remote)
        
        XCTAssertEqual(sync.get(forKey: DataStoreKey.iterationTimer.rawValue), "local",
                       "新しい方を使用する")
        XCTAssertEqual(local .result[.iterationTimer]!.latest, nil, "変化していないこと")
        XCTAssertEqual(local .result[.updateDate]!.latest    , nil, "変化していないこと")
        XCTAssertEqual(remote.result[.iterationTimer]!.latest, nil, "変化していないこと")
        XCTAssertEqual(remote.result[.updateDate]!.latest    , nil, "変化していないこと")
    }

    func testGetRemote() throws {
        let local = SynchronizerMockDataStore(initial: [.updateDate: "1", .iterationTimer: "local"])
        let remote = SynchronizerMockDataStore(initial: [.updateDate: "2", .iterationTimer: "remote"])
        
        let sync = DataStoreSynchronizer(local: local, remote: remote)
        
        XCTAssertEqual(sync.get(forKey: DataStoreKey.iterationTimer.rawValue), "remote",
                       "新しい方を使用する")
        XCTAssertEqual(local .result[.iterationTimer]!.latest, "remote", "新しい方で上書きされていること")
        XCTAssertEqual(local .result[.updateDate]!.latest    , "2"     , "新しい方で上書きされていること")
        XCTAssertEqual(remote.result[.iterationTimer]!.latest, nil, "変化していないこと")
        XCTAssertEqual(remote.result[.updateDate]!.latest    , nil, "変化していないこと")
    }

    func testSetLocalNewer() throws {
        let local = SynchronizerMockDataStore(initial: [.updateDate: "2", .iterationTimer: "local"])
        let remote = SynchronizerMockDataStore(initial: [.updateDate: "1", .iterationTimer: "remote"])
        
        let sync = DataStoreSynchronizer(local: local, remote: remote)
        
        sync.currentDateStrategy = { Date(timeIntervalSince1970: 3) }
        sync.set(value: "new", forKey: DataStoreKey.iterationTimer.rawValue)

        XCTAssertEqual(local .result[.iterationTimer]!.latest, "new", "新しい値で上書きされていること")
        XCTAssertEqual(local .result[.updateDate]!.latest    , "3"  , "新しい値で上書きされていること")
        XCTAssertEqual(remote.result[.iterationTimer]!.latest, "new", "新しい値で上書きされていること")
        XCTAssertEqual(remote.result[.updateDate]!.latest    , "3"  , "新しい値で上書きされていること")
        // 現状はiterationTimerしかKeyが無いが、今後増えた場合は以下のテストを有効化する。
//        XCTAssertEqual(local.result[<#newProperty#>]!.latest, remote.result[<#newProperty#>]!.latest, "setに関係のない値でもLocalの方が新しければuploadされていること")
    }

    func testGetRemoteNewer() throws {
        let local = SynchronizerMockDataStore(initial: [.updateDate: "1", .iterationTimer: "local"])
        let remote = SynchronizerMockDataStore(initial: [.updateDate: "2", .iterationTimer: "remote"])

        let sync = DataStoreSynchronizer(local: local, remote: remote)
        
        sync.currentDateStrategy = { Date(timeIntervalSince1970: 3) }
        sync.set(value: "new", forKey: DataStoreKey.iterationTimer.rawValue)

        XCTAssertEqual(local .result[.iterationTimer]!.latest, "new", "新しい値で上書きされていること")
        XCTAssertEqual(local .result[.updateDate]!.latest    , "3"  , "新しい値で上書きされていること")
        XCTAssertEqual(remote.result[.iterationTimer]!.latest, "new", "新しい値で上書きされていること")
        XCTAssertEqual(remote.result[.updateDate]!.latest    , "3"  , "新しい値で上書きされていること")
        // 現状はiterationTimerしかKeyが無いが、今後増えた場合は以下のテストを有効化する。
//        XCTAssertEqual(remote.result[<#newProperty#>]!.latest, .result[<#newProperty#>]!.latest, "setに関係のない値でもRemoteの方が新しければdownloadされていること")
    }
}

class SynchronizerMockDataStore: MockDataStore {
    var result: [DataStoreKey: (initial: String?, latest: String?)]
    
    init(initial: [DataStoreKey: String?]) {
        
        var result = [DataStoreKey: (initial: String?, latest: String?)]()
        DataStoreKey.allCases.forEach {
            result[$0] = (initial: initial[$0]!, latest: nil)
        }
        self.result = result
        
        super.init()

        self.onGet = { forKey in
            let key = DataStoreKey(rawValue: forKey)!
            return self.result[key]!.latest ?? self.result[key]?.initial
        }
        self.onSet = { (value, forKey) in
            let key = DataStoreKey(rawValue: forKey)!
            self.result[key]!.latest = value
        }
    }
}
