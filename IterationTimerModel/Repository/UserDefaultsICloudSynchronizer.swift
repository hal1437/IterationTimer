//
//  DataStoreSynchronizer.swift
//  IterationTimerCore
//
//  Created by hal1437 on 2021/11/28.
//

import Foundation
import IterationTimerCore

// 2つのDataStoreを同期しながら使用できるDataStore
public class DataStoreSynchronizer: DataStore {
    
    let local: DataStore
    let remote: DataStore
    var currentDateStrategy = { Date() }

    var dataStore: DataStore {
        return isRequireDownload ? remote : local
    }

    var isRequireDownload: Bool {
        // リモートとローカルのどちらにも updateDate が存在しない場合はリモートを利用する
        guard let localDate  = TimeInterval(local .get(forKey: DataStoreKey.updateDate.rawValue) ?? "0"),
              let remoteDate = TimeInterval(remote.get(forKey: DataStoreKey.updateDate.rawValue) ?? "0"),
              !(localDate == 0 && remoteDate == 0) else { return true }
        
        return localDate < remoteDate
    }
    
    public init(local: DataStore, remote: DataStore) {
        self.local = local
        self.remote = remote
    }
    
    public func `get`(forKey: String) -> String? {
        if isRequireDownload {
             download()
        }
        return dataStore.get(forKey: forKey)
    }
    
    public func `set`(value: String?, forKey: String) {
        if isRequireDownload {
             download()
        }
        local.set(value: String(Int64(currentDateStrategy().timeIntervalSince1970)), forKey: DataStoreKey.updateDate.rawValue)
        local.set(value: value, forKey: forKey)
        upload()
    }
    
    // UserDefaults -> iCloud
    private func upload() {
        copyData(from: local, to: remote)
    }
    
    // iCloud -> UserDefaults
    private func download() {
        copyData(from: remote, to: local)
    }
    
    private func copyData(from: DataStore, to: DataStore) {
        DataStoreKey.allCases.forEach {
            to.set(value: from.get(forKey: $0.rawValue), forKey: $0.rawValue)
        }
    }
}
