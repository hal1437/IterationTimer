//
//  RecentTimerWidget.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/10.
//

import SwiftUI
import IterationTimerModel
import WidgetKit

struct RecentTimerWidget: Widget {
    let kind = IterationTimerKind.recent.rawValue
    let repository: IterationTimerRepositoryProtocol
    
    init() {
        let dataStore = DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)
        self.repository = IterationTimerRepository(dataStore: dataStore)
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: RecentTimerWidgetTimelineProvider(repository: repository)) { entry in
            RecentTimer()
        }
        .configurationDisplayName("RecentTimerWidgetName")
        .description("RecentTimerWidgetDescription")
        .supportedFamilies([.systemSmall])
    }
}
