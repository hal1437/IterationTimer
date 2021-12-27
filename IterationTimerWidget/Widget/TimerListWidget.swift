//
//  TimerListWidget.swift
//  TimerListWidget
//
//  Created by hal1437 on 2021/06/09.
//

import SwiftUI
import IterationTimerModel
import WidgetKit

struct TimerListWidget: Widget {
    let kind = IterationTimerKind.list.rawValue
    let dataStore: DataStore
    let repository: IterationTimerRepositoryProtocol
    
    init() {
        self.dataStore = DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)
        self.repository = IterationTimerRepository(dataStore: dataStore)
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: TimerListWidgetTimelineProvider(repository: repository)) { entry in
            MultipleTimer(repository: IterationTimerRepository(dataStore: dataStore))
        }
        .configurationDisplayName("TimerListWidgetName")
        .description("TimerListWidgetDescription")
        .supportedFamilies([.systemMedium, .systemLarge, .systemExtraLarge])
    }
}
