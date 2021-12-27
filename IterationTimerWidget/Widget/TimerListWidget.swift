//
//  TimerListWidget.swift
//  TimerListWidget
//
//  Created by hal1437 on 2021/06/09.
//

import WidgetKit
import SwiftUI
import Intents
import IterationTimerUI
import IterationTimerModel

struct TimerListWidget: Widget {
    let kind = IterationTimerKind.list.rawValue
    let dataStore = DataStoreSynchronizer(local: UserDefaults.appGroups,
                                          remote: NSUbiquitousKeyValueStore.default)
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: AlmostAlwaysProvider()) { entry in
            MultipleTimer(repository: IterationTimerRepository(dataStore: dataStore))
        }
        .configurationDisplayName("TimerListWidgetName")
        .description("TimerListWidgetDescription")
        .supportedFamilies([.systemMedium, .systemLarge, .systemExtraLarge])
    }
}
