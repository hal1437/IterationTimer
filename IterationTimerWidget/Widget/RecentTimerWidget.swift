//
//  RecentTimerWidget.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/10.
//

import SwiftUI
import WidgetKit

struct RecentTimerWidget: Widget {
    let kind = IterationTimerKind.recent.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: AlmostAlwaysProvider()) { entry in
            RecentTimer()
        }
        .configurationDisplayName("RecentTimerWidgetName")
        .description("RecentTimerWidgetDescription")
        .supportedFamilies([.systemSmall])
    }
}
