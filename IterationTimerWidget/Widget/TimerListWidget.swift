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

struct TimerListWidget: Widget {
    let kind = IterationTimerKind.list.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: AlmostAlwaysProvider()) { entry in
            MultipleTimer()
        }
        .configurationDisplayName("TimerListWidgetName")
        .description("TimerListWidgetDescription")
        .supportedFamilies([.systemMedium, .systemLarge, .systemExtraLarge])
    }
}
